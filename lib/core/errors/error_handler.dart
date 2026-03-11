// lib/core/errors/error_handler.dart

import 'exception.dart';
import 'failures.dart';

Failure handleException(Exception e) {
  if (e is ServerException) {
    return ServerFailure(e.message);
  } else if (e is NetworkException) {
    return NetworkFailure(e.message);
  } else if (e is CacheException) {
    return CacheFailure(e.message);
  } else if (e is UnauthorizedException) {
    return UnauthorizedFailure(e.message);
  } else {
    return UnknownFailure("Unexpected error occurred");
  }
}
