class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class AuthorizationException implements Exception {}

class ValidateException implements Exception {
  String message;

  ValidateException(this.message);
}
