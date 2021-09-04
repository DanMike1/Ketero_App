abstract class AuthState {}

class LoggedOut extends AuthState {}

class LogInError extends AuthState {
  final String errMsg;

  LogInError({required this.errMsg});
}

class LoggedIn extends AuthState {}
