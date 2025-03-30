import 'dart:convert';
import 'package:http/http.dart';
import 'network_response.dart';

class NetworkClient {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson);
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson['data'] ?? 'Somthing went wrong';
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessage);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }
}
