import 'package:dio/dio.dart';

class ApiResponse<T> {
  late T data;
  late DioError error;
  bool hasError;
  bool hasData;

  ApiResponse.complete(this.data)
      : hasError = false,
        hasData = true;
  ApiResponse.error(this.error)
      : hasError = true,
        hasData = false;
}
