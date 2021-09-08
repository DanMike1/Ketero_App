import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/l10n/messages_de.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';
import 'package:http/http.dart' as http;
import '../screens/login.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      // final email = event.email;
      // final password = event.password;
      yield LoginLoading();
      var response = await login(event.email, event.password);
      try {
        print(event.email);
        print(response['success']);
        if (response["success"] != true) {
          yield LogInError(errMsg: response['message']);
        } else {
          yield LoggedIn(response: jsonEncode(response));
          // AuthBloc.add(LoggedIn(response: re["body"]));
        }
      } catch (error) {
        print(error);
        yield LogInError(errMsg: "Invalid Credentials!");
      }
    }
    // if (email == "dan@man.com") {
    //   print('email');
    //   if (password == "1234") {
    //     yield LoggedIn();
    //     await Future.delayed(Duration(seconds: 2));
    //   } else {
    //     yield LogInError(errMsg: "Not Valid");
    //     await Future.delayed(Duration(seconds: 2));
    //     yield LoggedOut();
    //   }
    // } else {
    //   yield LogInError(errMsg: "Not an Account");
    //   await Future.delayed(Duration(seconds: 2));
    //   yield LoggedOut();
    // }
  }
}

// Future<Map<String, dynamic>> login(
//   String email,
//   String password,
// ) async {
//   Map<String, String> res;
//   try {
//     var url = "http://10.0.2.2:3000/api/users/login";
//     var response = await http.get(Uri.parse(url));
//     var responseBody = response.body;
//     return {
//       "body": json.encode(responseBody),
//       "status": response.statusCode.toString(),
//       // "message": responseBody[message],
//     };
//   } catch (e) {
//     return {"status": "farta", "message": "Wrong URL or sth"};
//   }
// }
