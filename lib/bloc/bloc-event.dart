abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() =>
      'LoginButtonPressed {email: $email , password:$password}';
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class UpdateUser extends AuthEvent{
  final String email;
  final String password;
  final String username;

  UpdateUser({
    required this.email,
    required this.password,
    required this.username,
  });
}
class AddEvents extends AuthEvent {
  final String title;
  final String description;
  final DateTime targeted_date;

  AddEvents(
      {required this.title,
      required this.description,
      required this.targeted_date});
  @override
  List<Object> get props => [title, description, targeted_date];
  @override
  String toString() =>
      'LoginButtonPressed {title: $title , targeted_date:$targeted_date, description:$description}';
}
