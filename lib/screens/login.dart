import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/bloc/bloc_state.dart';
import 'package:ketero_app/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = '/login';
  LoginScreen({Key? key}) : super(key: key);
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') != null) {
        Navigator.of(context).pushNamed("/navBar");
      }
    }

    checkLogin();

    final inputStyle = InputDecoration(border: OutlineInputBorder());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Have a",
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
                            "Qeter",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.access_time,
                            size: 50,
                            color: Colors.amber,
                          ),
                          Text(
                            "?",
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                  TextFormField(
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
                        hintText: "Email"),
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
                    height: 35,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (ctx, authState) async {
                      Navigator.of(context).pushNamed('/login');
                    },
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
                            authBloc.add(
                                LoginEvent(email: email, password: password));
                            // print(email);
                            // print(password);
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
                          child: SignUpScreen(),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(children: [
                          Text("don't have an account? ",
                              style: TextStyle(fontSize: 19)),
                          Text(
                            "signUp",
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

// login(email, password) async {
//   var url = "http://10.0.2.2:3000/api/users/login";
//   final response = await http.post(
//     Uri.parse(url),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );
//   if (response.statusCode == 200) {
//     print(jsonDecode(response.body));

//     return (jsonDecode(response.body));
//   } else {
//     return Text('404');
//   }
// }
