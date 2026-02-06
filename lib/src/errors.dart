/// Base exception for SafeNest SDK errors.
class SafeNestException implements Exception {
  const SafeNestException(this.message, [this.details]);

  final String message;
  final dynamic details;

  @override
  String toString() => 'SafeNestException: $message';
}

/// Thrown when API key is invalid or missing.
class AuthenticationException extends SafeNestException {
  const AuthenticationException(super.message, [super.details]);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Thrown when rate limit is exceeded.
class RateLimitException extends SafeNestException {
  const RateLimitException(super.message, [super.details]);

  @override
  String toString() => 'RateLimitException: $message';
}

/// Thrown when request validation fails.
class ValidationException extends SafeNestException {
  const ValidationException(super.message, [super.details]);

  @override
  String toString() => 'ValidationException: $message';
}

/// Thrown when a resource is not found.
class NotFoundException extends SafeNestException {
  const NotFoundException(super.message, [super.details]);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Thrown when the server returns a 5xx error.
class ServerException extends SafeNestException {
  const ServerException(super.message, this.statusCode, [super.details]);

  final int statusCode;

  @override
  String toString() => 'ServerException ($statusCode): $message';
}

/// Thrown when a request times out.
class TimeoutException extends SafeNestException {
  const TimeoutException(super.message, [super.details]);

  @override
  String toString() => 'TimeoutException: $message';
}

/// Thrown when a network error occurs.
class NetworkException extends SafeNestException {
  const NetworkException(super.message, [super.details]);

  @override
  String toString() => 'NetworkException: $message';
}
