import 'package:dartz/dartz.dart';

abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

class ServerFailure extends Failure {
  const ServerFailure({required String message, int? statusCode})
    : super(message: message, statusCode: statusCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message: message);
}

class LocationFailure extends Failure {
  const LocationFailure({required String message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required String message})
    : super(message: message);
}

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
