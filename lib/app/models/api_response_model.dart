
class ApiResponse<T> {
  late T data;
  late RequestError error;
  bool hasError;
  bool hasData;

  ApiResponse.complete(this.data)
      : hasError = false,
        hasData = true;
  ApiResponse.error(this.error)
      : hasError = true,
        hasData = false;
}

class RequestError {
  final String error;
  RequestError(this.error);
}
