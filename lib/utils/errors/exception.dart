class CustomException implements Exception {
  final String msg;

  CustomException(this.msg);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException(this.message);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => message;
}

class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);

  @override
  String toString() => message;
}

class ConnectionTimeOutException implements Exception {
  final String message;

  ConnectionTimeOutException(this.message);

  @override
  String toString() => message;
}

class SendTimeoutException implements Exception {
  final String message;

  SendTimeoutException(this.message);

  @override
  String toString() => message;
}

class ReceiveTimeoutException implements Exception {
  final String message;

  ReceiveTimeoutException(this.message);

  @override
  String toString() => message;
}

class BadCertificateException implements Exception {
  final String message;

  BadCertificateException(this.message);

  @override
  String toString() => message;
}

class BadResponseException implements Exception {
  final String message;

  BadResponseException(this.message);

  @override
  String toString() => message;
}

class CancelException implements Exception {
  final String message;

  CancelException(this.message);

  @override
  String toString() => message;
}

class ConnectionErrorException implements Exception {
  final String message;

  ConnectionErrorException(this.message);

  @override
  String toString() => message;
}

class UnknownErrorException implements Exception {
  final String message;

  UnknownErrorException(this.message);

  @override
  String toString() => message;
}
