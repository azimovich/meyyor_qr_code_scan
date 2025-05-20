class ApiResponse {
  final int statusCode;
  final bool isSuccess;
  final dynamic data;

  ApiResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.data,
  });
}
