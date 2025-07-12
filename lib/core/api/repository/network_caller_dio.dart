import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:task_manager/core/api/model/api_response_dio.dart';
import 'package:task_manager/core/utils/logger.dart';

class NetworkCaller {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://your-api.com/api/v1",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static void setAuthToken(String token) {
    AppLoggerHelper.info('🔐 Set Auth Token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeAuthToken() {
    AppLoggerHelper.info('🚫 Remove Auth Token');
    _dio.options.headers.remove('Authorization');
  }

  static Future<ApiResponse> get(String url, {Map<String, dynamic>? params}) async {
    try {
      AppLoggerHelper.info('🌐 GET Request: $url');
      AppLoggerHelper.debug('Query: $params');
      final response = await _dio.get(url, queryParameters: params);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> post(String url, {Map<String, dynamic>? body}) async {
    try {
      AppLoggerHelper.info('📤 POST Request: $url');
      AppLoggerHelper.debug('Body: $body');
      final response = await _dio.post(url, data: body);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> postFormUrlEncoded(String url, Map<String, dynamic> body) async {
    try {
      AppLoggerHelper.info('📤 POST (form-urlencoded): $url');
      AppLoggerHelper.debug('Body: $body');
      final response = await _dio.post(
        url,
        data: body,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> put(String url, {Map<String, dynamic>? body}) async {
    try {
      AppLoggerHelper.info('✏️ PUT Request: $url');
      AppLoggerHelper.debug('Body: $body');
      final response = await _dio.put(url, data: body);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> delete(String url) async {
    try {
      AppLoggerHelper.info('🗑️ DELETE Request: $url');
      final response = await _dio.delete(url);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> patch(String url, {Map<String, dynamic>? body}) async {
    try {
      AppLoggerHelper.info('🩹 PATCH Request: $url');
      AppLoggerHelper.debug('Body: $body');
      final response = await _dio.patch(url, data: body);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> patchWithoutBody(String url) async {
    try {
      AppLoggerHelper.info('🩹 PATCH (No Body): $url');
      final response = await _dio.patch(url);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> uploadSingleImage(
      String url,
      File imageFile, {
        Map<String, dynamic>? body,
        String fieldName = "avatar",
      }) async {
    try {
      AppLoggerHelper.info('📸 Upload Single Image to: $url');
      final mimeType = lookupMimeType(imageFile.path);
      final formData = FormData.fromMap({
        if (body != null) ...body,
        fieldName: await MultipartFile.fromFile(
          imageFile.path,
          filename: path.basename(imageFile.path),
          contentType: MediaType.parse(mimeType ?? 'image/jpeg'),
        ),
      });

      final response = await _dio.put(url, data: formData);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> uploadTwoImages(
      String url,
      File front,
      File back, {
        Map<String, dynamic>? body,
        String field1 = "IDCardFont",
        String field2 = "IDCardBack",
      }) async {
    try {
      AppLoggerHelper.info('📸 Upload Two Images to: $url');
      final formData = FormData.fromMap({
        if (body != null) ...body,
        field1: await MultipartFile.fromFile(front.path, filename: path.basename(front.path)),
        field2: await MultipartFile.fromFile(back.path, filename: path.basename(back.path)),
      });

      final response = await _dio.patch(url, data: formData);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> uploadMultipleImages(
      String url,
      List<File> files, {
        Map<String, dynamic>? body,
      }) async {
    try {
      AppLoggerHelper.info('📸 Upload Multiple Images to: $url');
      final formData = FormData();

      if (body != null) {
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      for (var file in files) {
        final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
        formData.files.add(
          MapEntry(
            'files[]',
            await MultipartFile.fromFile(
              file.path,
              filename: path.basename(file.path),
              contentType: MediaType.parse(mimeType),
            ),
          ),
        );
      }

      final response = await _dio.post(url, data: formData);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static ApiResponse _handleResponse(Response response) {
    AppLoggerHelper.info('✅ Response ${response.statusCode}: ${response.requestOptions.uri}');
    AppLoggerHelper.debug('Response Body: ${response.data}');

    final data = response.data;
    return ApiResponse(
      isSuccess: (response.statusCode == 200 || response.statusCode == 201),
      statusCode: response.statusCode,
      data: data['result'] ?? data,
      errorMessage: data['message'] ?? '',
    );
  }

  static ApiResponse _handleError(dynamic error) {
    AppLoggerHelper.error('❌ Dio Error: $error');

    if (error is DioException) {
      final res = error.response;
      AppLoggerHelper.warning(
          'DioException [${res?.statusCode}] - ${res?.requestOptions.uri} - ${res?.data}');
      return ApiResponse(
        isSuccess: false,
        statusCode: res?.statusCode,
        data: res?.data,
        errorMessage: res?.data?['message'] ?? error.message ?? 'Request failed',
      );
    } else {
      AppLoggerHelper.error("Unhandled Exception: $error");
      return ApiResponse(
        isSuccess: false,
        statusCode: 500,
        data: null,
        errorMessage: 'Unexpected error occurred',
      );
    }
  }
}
