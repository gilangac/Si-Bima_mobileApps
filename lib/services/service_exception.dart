class ServiceException implements Exception {
  final String message;
  final String? prefix;
  final String? url;

  ServiceException(this.message, [this.prefix, this.url]);
}

class BadRequestException extends ServiceException {
  BadRequestException(String message, [String? url])
      : super(message, 'Bad request', url);
}

class FetchDataException extends ServiceException {
  FetchDataException(String message, [String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends ServiceException {
  ApiNotRespondingException(String message, [String? url])
      : super(message, 'Api not responded in a time', url);
}

class UnauthorizedException extends ServiceException {
  UnauthorizedException(String message, [String? url])
      : super(message, 'Unauthorized request', url);
}
