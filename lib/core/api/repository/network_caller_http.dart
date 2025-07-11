import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feature_bites/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import '../model/api_response_http.dart';

class NetworkCaller {
  final int timeoutDuration = 80;
  String? token;

  /* ───────────────────────────── GET ───────────────────────────── */
  Future<ResponseData> getRequest(String url, {String? token}) async {
    AppLoggerHelper.info('GET Request: $url');
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('GET request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ───────────────────────────── POST ──────────────────────────── */
  Future<ResponseData> postRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    AppLoggerHelper.info('POST Request: $url');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Authorization': token ?? '',
          'Content-Type':'application/json'
        },


        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('POST request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequestForPayment(
      String url, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    AppLoggerHelper.info('POST Request: $url');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-type':  'application/x-www-form-urlencoded',
          'Authorization': token ?? '',
        },

        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('POST request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequestWithoutBody(
    String url, {
    String? token,
  }) async {
    AppLoggerHelper.info('POST Request: $url');

    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('POST request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ───────────────────────────── PUT ───────────────────────────── */
  Future<ResponseData> putRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    AppLoggerHelper.info('PUT Request: $url');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await put(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('PUT request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ──────────────────────────── DELETE ─────────────────────────── */
  Future<ResponseData> deleteRequest(String url, String? token) async {
    AppLoggerHelper.info('DELETE Request: $url');

    try {
      final Response response = await delete(
        Uri.parse(url),
        headers: {
          'Authorization': token ?? "",
          'Content-type': 'application/json',
        },
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('DELETE request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ──────────────────────────── PATCH (JSON body) ──────────────── */
  Future<ResponseData> patchRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    AppLoggerHelper.info('PATCH Request: $url');
    AppLoggerHelper.info('PATCH body: $body');

    try {
      final Response response = await patch(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('PATCH request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ─────────────────── PATCH (no body) ─────────────────── */
  Future<ResponseData> patchRequestWithoutBody(
    String url, {
    String? token,
  }) async {
    AppLoggerHelper.info('PATCH Request: $url');

    try {
      final Response response = await patch(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      AppLoggerHelper.error('PATCH (no‑body) request error: $e'); // ⬅️ added
      return _handleError(e);
    }
  }

  /* ─────────────────── Multipart (single image) ────────────────── */

  Future<Map<String, dynamic>> putFormDataWithImage({
    required String res, // 'PUT'
    required String url,
    required Map<String, dynamic> body,
    required File imageFile,
    String? token = "",
    String imageName = "avatar",
  }) async {
    log('Request token: $token');
    log('Request Body: ${jsonEncode(body)}');

    try {
      var request = http.MultipartRequest(res, Uri.parse(url));

      if (token != null && token.isNotEmpty) {
        request.headers.addAll({'Authorization': token});
      }

      String filePath = imageFile.path;
      String? mimeType = lookupMimeType(filePath);

      if (mimeType == null) {
        log('Could not determine MIME type for the file');
        return {'success': false, 'message': 'Invalid file type'};
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          imageName,
          filePath,
          contentType: MediaType.parse(mimeType),
        ),
      );

      request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Success',
          'data': jsonDecode(response.body),
        };
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      AppLoggerHelper.error('Form‑data error: $e');
      return {'success': false, 'message': 'Exception: $e'};
    }
  }



  /* Future<Map<String, dynamic>> putFormDataWithImage(
{
  required String res,
  required String url,
  required Map<String, dynamic> body,
  required File imageFile,
  String? token = "",
  String imageName = "avatar",
  }) async {
    log('Request token: $token');
    log('Request Body: ${jsonEncode(body)}');

    try {
      var request = http.MultipartRequest(res, Uri.parse(url));
      request.headers.addAll({'Authorization': token ?? ""});

      String filePath = imageFile.path;
      String? mimeType = lookupMimeType(filePath);

      if (mimeType == null) {
        log('Could not determine MIME type for the file');
        return {'success': false, 'message': 'Invalid file type'};
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          imageName,
          filePath,
          contentType: MediaType.parse(mimeType),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Success',
          'data': jsonDecode(response.body),
        };
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      AppLoggerHelper.error('Form‑data (single image) error: $e'); // ⬅️ added
      return {'success': false, 'message': 'Exception: $e'};
    }
  }*/

  /* ─────────────── Multipart (two documents) ─────────────── */
  Future<Map<String, dynamic>> patchDocuments(
    String res,
    String url,
    Map<String, dynamic> body,
    File imageFontFile,
    File imageBackFile, {
    String? token = "",
    String iDCardFont = "IDCardFont",
    String iDCardBack = "IDCardBack",
  }) async {
    log('Request token: $token');
    log('Request Body: ${jsonEncode(body)}');

    try {
      var request = http.MultipartRequest(res, Uri.parse(url));
      request.headers.addAll({'Authorization': token ?? ""});

      String fontPath = imageFontFile.path;
      String backPath = imageBackFile.path;
      String? mimeFont = lookupMimeType(fontPath);
      String? mimeBack = lookupMimeType(backPath);

      if (mimeFont == null) {
        log('Could not determine MIME type for the file');
        return {'success': false, 'message': 'Invalid Font file type'};
      }
      if (mimeBack == null) {
        log('Could not determine MIME type for the file');
        return {'success': false, 'message': 'Invalid Back file type'};
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          iDCardFont,
          fontPath,
          contentType: MediaType.parse(mimeFont),
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          iDCardBack,
          backPath,
          contentType: MediaType.parse(mimeBack),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Success',
          'data': jsonDecode(response.body),
        };
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      AppLoggerHelper.error('Form‑data (two docs) error: $e'); // ⬅️ added
      return {'success': false, 'message': 'Exception: $e'};
    }
  }

  /* ─────────────── Multipart (dynamic list) ─────────────── */

  Future<String> sendFormDataWithImage(
    String url,
    dynamic body,
    List<dynamic> imageFiles, {
    String? token,
  }) async {
    try {
      AppLoggerHelper.info('Patch Request: $url');
      AppLoggerHelper.info('Patch body: $body');
      AppLoggerHelper.info('Patch body: $imageFiles');
      var request = MultipartRequest('PATCH', Uri.parse(url));

      request.fields['textData'] = jsonEncode(body);

      if (imageFiles.isNotEmpty) {
        final mimeType = lookupMimeType(imageFiles[0].path);
        debugPrint("MIME Type (IDCardFont): $mimeType");
        var fontFile = await MultipartFile.fromPath(
          'IDCardFont',
          imageFiles[0].path,
          filename: path.basename(imageFiles[0].path),
        );
        debugPrint(fontFile.filename);
        request.files.add(fontFile);
      }
      if (imageFiles.length > 1) {
        final mimeType = lookupMimeType(imageFiles[1].path);
        debugPrint("MIME Type (IDCardBack): $mimeType");
        var backFile = await MultipartFile.fromPath(
          'IDCardBack',
          imageFiles[1].path,
          filename: path.basename(imageFiles[1].path),
        );
        debugPrint(backFile.filename);
        request.files.add(backFile);
      }

      request.headers.addAll({'Authorization': token!});

      var response = await request.send();
      var data = await Response.fromStream(response);
      AppLoggerHelper.info('Patch response: ${data.body}');
      if (response.statusCode == 307) {
        return jsonDecode(data.body)["message"];
      }
      debugPrint(jsonDecode(data.body).toString());
      if (response.statusCode == 201) {
        return "Success";
      } else {
        return jsonDecode(data.body).toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  /* ─────────────────── Common Response Handler ─────────────────── */
  ResponseData _handleResponse(Response response) {
    AppLoggerHelper.info('Response Status: ${response.statusCode}');
    AppLoggerHelper.info('Response Body: ${response.body}');

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decoded['success'] == true) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decoded['result'],
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decoded,
          errorMessage: decoded['message'] ?? 'Unknown error occurred',
        );
      }
    } else if (response.statusCode == 400) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decoded,
        errorMessage: _extractErrorMessages(decoded['errorSources']),
      );
    } else if (response.statusCode == 500) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decoded,
        errorMessage: decoded['message'] ?? 'An unexpected error occurred!',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decoded,
        errorMessage: decoded['message'] ?? 'An unknown error occurred',
      );
    }
  }

  /* ─────────────────── Extract Validation Messages ─────────────── */
  String _extractErrorMessages(dynamic errorSources) {
    if (errorSources is List) {
      return errorSources
          .map((error) => error['message'] ?? 'Unknown error')
          .join(', ');
    }
    return 'Validation error';
  }

  /* ─────────────────── Generic Error Handler ───────────────────── */
  ResponseData _handleError(dynamic error) {
    AppLoggerHelper.error('Request Error: $error'); // ⬅️ added

    if (error is ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }

  /* ─────────────────── Raw GET (returns Response) ───────────────── */
  Future<Response?> getRequestForData(String url, {String? token}) async {
    AppLoggerHelper.info('GET Request: $url');
    AppLoggerHelper.info('GET Token: $token');

    Response? response;

    try {
      response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));

      final decoded = jsonDecode(response.body);
      if (decoded['success']) {
        log(response.headers.toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        return response;
      }
    } catch (e) {
      AppLoggerHelper.error('Raw GET error: $e'); // ⬅️ added
      return response;
    }
    return null;
  }
}
