class ApiResponse {
  final dynamic data;
  final bool isSuccess;
  final int? statusCode;
  final String? errorMessage;

  ApiResponse({required this.isSuccess, this.data, this.errorMessage, this.statusCode});
}
