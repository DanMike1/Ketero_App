import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/l10n/messages_de.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';
import 'package:http/http.dart' as http;
// import '../screens/login.dart';

class AuthBlocEvent extends Bloc<AuthEvent, AuthState> {
  AuthBlocEvent() : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AddEvents) {
      // final email = event.email;
      // final password = event.password;
      var response =
          await postTask(event.title, event.description, event.targeted_date);
      try {
        print(event.title);
        print(response['success']);
        if (response["success"] != true) {
          yield AddEventError(errMsg: response['message']);
        } else {
          yield AddedEvents(response: jsonEncode(response));
          print(response);
        }
      } catch (error) {
        print(error);
        yield AddEventError(errMsg: "Invalid Credentials!");
      }
    }
  }
}

postTask(title, description, targeted_date) async {
  var url = "http://10.0.2.2:3000/api/tasks";
  // var parse = jsonDecode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  final response = await http.post(
    Uri.parse(url),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8', //!!!!!!!!!!!!!!!
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description,
      'target_date': targeted_date.toString(),
    }),
  );
  if (response.statusCode == 201) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    return parse;
  } else {
    return Text('201');
  }
  // final responseJson = jsonDecode(response.body);
  // print(responseJson);
  // return responseJson;
}

getFetchedEvent() async {
  var url = "http://10.0.2.2:3000/api/tasks";
  // var parse = jsonDecode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  final response = await http.get(
    Uri.parse(url),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );
  final responseJson = jsonDecode(response.body);
  print(responseJson);
  return responseJson;
}



    // checkLogin()
