import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      final email = event.email;
      final password = event.password;
      if (email == "dan@man.com") {
        print('email');
        if (password == "1234") {
          yield LoggedIn();
          await Future.delayed(Duration(seconds: 2));
        } else {
          yield LogInError(errMsg: "Not Valid");
          await Future.delayed(Duration(seconds: 2));
          yield LoggedOut();
        }
      } else {
        yield LogInError(errMsg: "Not an Account");
        await Future.delayed(Duration(seconds: 2));
        yield LoggedOut();
      }
    }
  }
}
