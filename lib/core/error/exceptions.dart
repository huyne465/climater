class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class LocationException implements Exception {
  final String message;

  const LocationException({required this.message});

  @override
  String toString() => 'LocationException: $message';
}

class InvalidInputException implements Exception {
  final String message;

  const InvalidInputException({required this.message});

  @override
  String toString() => 'InvalidInputException: $message';
}
