abstract class Failure {
  final String message;

  Failure({required this.message});
}

class DatabaseFailure implements Failure {
  final String message;

  DatabaseFailure({
    this.message = "Something went wrong",
  });
}

class AuthFailure implements Failure {
  final String message;

  AuthFailure({
    required this.message,
  });
}
