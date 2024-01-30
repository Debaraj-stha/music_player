class AppException implements Exception {
  final String? _message;
  final String? _prefix;
  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? _message])
      : super(_message, "Error in communication");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid request:");
}

class UnAuthorizedRequest extends AppException {
  UnAuthorizedRequest([String? message])
      : super(message, "Unauthorized request:");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input:");
}

class InternalServerError extends AppException {
  InternalServerError([String? message]) : super(message, "Server Error:");
}
