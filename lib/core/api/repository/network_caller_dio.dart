import 'package:dio/dio.dart';
import 'package:flutter_feature_bites/core/api/model/api_response_dio.dart';

class NetworkCaller {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://your-api.com/api/v1", // ✅ Set your base URL
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  static Future<ApiResponse> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return ApiResponse(isSuccess: true, data: response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> post(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(url, data: body);
      return ApiResponse(isSuccess: true, data: response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> put(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.put(url, data: body);
      return ApiResponse(isSuccess: true, data: response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<ApiResponse> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return ApiResponse(isSuccess: true, data: response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static ApiResponse _handleError(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      return ApiResponse(
        isSuccess: false,
        errorMessage: response?.data['message'] ?? 'Something went wrong',
        statusCode: response?.statusCode,
      );
    } else {
      return ApiResponse(isSuccess: false, errorMessage: 'Unexpected error');
    }
  }
}
