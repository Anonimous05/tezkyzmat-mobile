import 'package:equatable/equatable.dart';

class ErrorException extends Equatable implements Exception {
  const ErrorException({required this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class FetchDataException extends ErrorException {
  const FetchDataException(message) : super(message: message as String);
}

class BadRequestException extends ErrorException {
  const BadRequestException(message) : super(message: message as String);
}

class UnauthorizedException extends ErrorException {
  const UnauthorizedException(message) : super(message: message as String);
}

class NotFoundException extends ErrorException {
  const NotFoundException([message]) : super(message: message as String);
}

class ConflictException extends ErrorException {
  const ConflictException([message]) : super(message: message as String);
}

class InternalServerErrorException extends ErrorException {
  const InternalServerErrorException([message])
      : super(message: message as String);
}

class NoInternetConnectionException extends ErrorException {
  const NoInternetConnectionException([message])
      : super(message: message as String);
}

class CacheException extends ErrorException {
  const CacheException([message]) : super(message: message as String);
}
