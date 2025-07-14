import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/utils/logger.dart';

class NetworkCaller {
  static const int timeoutDuration = 80;

  // Helper to build headers with optional token
  static Map<String, String> _buildHeaders({String? token, bool isJson = true}) {
    final headers = <String, String>{};
    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }
    if (token != null && token.isNotEmpty) {
      headers['token'] = token;

      AppLoggerHelper.debug('Request headers: $headers');
    }
    return headers;
  }

  // GET request
  static Future<ResponseData> getRequest(String url, {String? token}) async {
    AppLoggerHelper.info('GET Request: $url');
    try {
      final response = await http
          .get(Uri.parse(url), headers: _buildHeaders(token: token))
          .timeout(const Duration(seconds: timeoutDuration));

      log('GET Headers: ${response.headers}');
      log('GET Status: ${response.statusCode}');
      log('GET Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST request
  static Future<ResponseData> postRequest(
      String url, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    AppLoggerHelper.info('POST Request: $url');
    AppLoggerHelper.info('POST Body: ${jsonEncode(body)}');
    try {
      final response = await http
          .post(Uri.parse(url),
          headers: _buildHeaders(token: token),
          body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutDuration));

      log('POST Status: ${response.statusCode}');
      log('POST Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // PUT request
  static Future<ResponseData> putRequest(
      String url, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    AppLoggerHelper.info('PUT Request: $url');
    AppLoggerHelper.info('PUT Body: ${jsonEncode(body)}');
    try {
      final response = await http
          .put(Uri.parse(url),
          headers: _buildHeaders(token: token),
          body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutDuration));

      log('PUT Status: ${response.statusCode}');
      log('PUT Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // DELETE request
  static Future<ResponseData> deleteRequest(String url, {String? token}) async {
    AppLoggerHelper.info('DELETE Request: $url');
    try {
      final response = await http
          .delete(Uri.parse(url), headers: _buildHeaders(token: token))
          .timeout(const Duration(seconds: timeoutDuration));

      log('DELETE Status: ${response.statusCode}');
      log('DELETE Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // PATCH request
  static Future<ResponseData> patchRequest(
      String url, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    AppLoggerHelper.info('PATCH Request: $url');
    AppLoggerHelper.info('PATCH Body: ${jsonEncode(body)}');
    try {
      final response = await http
          .patch(Uri.parse(url),
          headers: _buildHeaders(token: token),
          body: jsonEncode(body))
          .timeout(const Duration(seconds: timeoutDuration));

      log('PATCH Status: ${response.statusCode}');
      log('PATCH Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle response common for all requests
  static ResponseData _handleResponse(http.Response response) {
    AppLoggerHelper.info('Response Status: ${response.statusCode}');
    AppLoggerHelper.info('Response Body: ${response.body}');

    dynamic decodedResponse;
    try {
      decodedResponse = jsonDecode(response.body);
    } catch (_) {
      decodedResponse = null;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodedResponse is Map && decodedResponse['status'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: {
            "data": decodedResponse['data'],
            "token": decodedResponse['token']
          },
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse?['message'] ?? 'Unexpected format received',
        );
      }
    } else if (response.statusCode == 400) {
      return ResponseData(
        isSuccess: false,
        statusCode: 400,
        responseData: decodedResponse,
        errorMessage: _extractErrorMessages(decodedResponse?['errorSources']),
      );
    } else if (response.statusCode == 401) {
      return ResponseData(
        isSuccess: false,
        statusCode: 401,
        responseData: decodedResponse,
        errorMessage: 'Unauthorized access - please login again.',
      );
    } else if (response.statusCode == 500) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: decodedResponse,
        errorMessage: decodedResponse?['message'] ?? 'An unexpected server error occurred!',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse?['message'] ?? 'An unknown error occurred',
      );
    }
  }


  static String _extractErrorMessages(dynamic errorSources) {
    if (errorSources is List) {
      return errorSources.map((e) => e['message'] ?? 'Unknown error').join(', ');
    }
    return 'Validation error';
  }

  // Handle errors thrown during requests
  static ResponseData _handleError(dynamic error) {
    AppLoggerHelper.error('Request Error: $error');

    if (error is SocketException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 0,
        responseData: null,
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: null,
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 0,
        responseData: null,
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }
}
