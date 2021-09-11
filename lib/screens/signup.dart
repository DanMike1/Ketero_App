import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';
import 'package:ketero_app/widget/navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:page_transition/page_transition.dart';

import 'login.dart';

class SignUpScreen extends StatelessWidget {
  static const String routename = '/signUp';
  SignUpScreen({Key? key}) : super(key: key);
  final firstTextController = TextEditingController();
  final lastTextController = TextEditingController();
  final userTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var firstname;
  var lastname;
  var email;
  var username;
  var password;
  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(border: OutlineInputBorder());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Join us here at",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            " ",
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Qetero",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.access_time,
                            size: 60,
                            color: Colors.amber,
                          ),
                          Text(
                            "?",
                            style: TextStyle(
                                fontSize: 70, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5 - 28,
                        child: TextFormField(
                          onChanged: (value) {
                            firstname = value;
                            // emailTextController = value;
                          },
                          controller: firstTextController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              labelText: "First Name"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5 - 27,
                        child: TextFormField(
                          onChanged: (value) {
                            lastname = value;
                            // emailTextController = value;
                          },
                          controller: lastTextController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              labelText: "Last Name"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5 - 28,
                        child: TextFormField(
                          onChanged: (value) {
                            username = value;
                            // emailTextController = value;
                          },
                          controller: userTextController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              labelText: "Username"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5 - 27,
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                            // emailTextController = value;
                          },
                          controller: emailTextController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              labelText: "Email"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    controller: passwordTextController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (ctx, authState) {
                      if (authState is SignedUp) {
                        Navigator.of(context).pushNamed(navBar.routeName);
                      }
                    },
                    builder: (context, state) {
                      print(state);
                      Widget buttonText = Text("Sign UP");
                      if (state is SignedUp) {
                        buttonText = Row(children: [
                          SizedBox(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            height: 20.0,
                            width: 20.0,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          buttonText =
                              Text("Sign Up", style: TextStyle(fontSize: 15))
                        ]);
                      }
                      if (state is SignUpError) {
                        buttonText = Text(state.errMsg);
                      }

                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(
                                      left: 140,
                                      right: 140,
                                      top: 20,
                                      bottom: 20)),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 17)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)))),
                          onPressed: () {
                            final authBloc = BlocProvider.of<AuthBloc>(context);
                            authBloc.add(SignUpEvent(
                                email: email,
                                password: password,
                                username: username));
                            // print(email);
                            // print(password);
                            // print(username);
                            signUp(email, password, username, firstname,lastname);
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: FittedBox(child: buttonText));
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: Duration(milliseconds: 350),
                          child: LoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(children: [
                          Text("Already have an account? ",
                              style: TextStyle(fontSize: 19)),
                          Text(
                            "Log In",
                            style: TextStyle(color: Colors.amber, fontSize: 19),
                          )
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

signUp(email, password, username, firstname, lastname) async {
  var url = "http://10.0.2.2:3000/api/users/register-user";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'username': username,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(jsonDecode(response.body));

    return (jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    // throw Exception('Failed to create signUp.');
    return Text('User Already Exits');
  }
}
