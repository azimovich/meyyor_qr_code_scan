abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class BadResponceFailure extends Failure {
  const BadResponceFailure(super.message);
}

class UnautorizedFailure extends Failure {
  const UnautorizedFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UrlNotFoundFailure extends Failure {
  const UrlNotFoundFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class JsonParsingError extends Failure {
  const JsonParsingError(super.message);
}
