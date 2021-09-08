abstract class AuthState {}

class LoggedOut extends AuthState {}

class LogInError extends AuthState {
  final String errMsg;

  LogInError({required this.errMsg});
}

class LoginLoading extends AuthState {}

class LoggedIn extends AuthState {
  final String response;
  LoggedIn({required this.response});
  @override
  List<Object> get props => [response];

  @override
  String toString() => 'Logged In {$response}';
}

class SignUpError extends AuthState {
  final String errMsg;

  SignUpError({required this.errMsg});
}

class SignedUp extends AuthState {}
