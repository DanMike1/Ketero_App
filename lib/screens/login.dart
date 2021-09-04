import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = '/login';
  LoginScreen({Key? key}) : super(key: key);
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(border: OutlineInputBorder());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
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
                        "Have A",
                        style: TextStyle(
                          fontSize: 70,
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
                        "Qeter",
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
              TextFormField(
                controller: emailTextController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    hintText: "Email"),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
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
                height: 45,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  print(state);
                  Widget buttonText = Text("LOGIN");
                  if (state is LoggedIn) {
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
                          Text("LOGGING IN", style: TextStyle(fontSize: 15))
                    ]);
                  }
                  if (state is LogInError) {
                    buttonText = Text(state.errMsg);
                  }

                  return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: 140, right: 140, top: 20, bottom: 20)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 17)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)))),
                      onPressed: () {
                        final authBloc = BlocProvider.of<AuthBloc>(context);

                        authBloc.add(LoginEvent(
                            email: emailTextController.text,
                            password: passwordTextController.text));
                      },
                      child: FittedBox(child: buttonText));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
