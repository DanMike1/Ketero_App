
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/model/classes/user.dart';
import 'package:ketero_app/screens/calendar.dart';
import 'package:ketero_app/widget/navigation.dart';
import 'package:ketero_app/widget/profile_pic.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<User> _updateUser;
  static const String routename = "/user";
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool isObscure = true;
  @override
  void initState() {
    super.initState();
    _updateUser = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "KETERO",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 350),
                        child: CalendarPage(),
                      ),
                    )
                  },
              icon: Icon(
                Icons.calendar_today,
                color: Colors.amber,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    ProfilePic(),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Colors.amber.withOpacity(0.6)),
                              color: Colors.amber),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                child: FutureBuilder<User>(
                  future: _updateUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.username.toString()),
                            TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                hintText: 'Username',
                              ),
                            ),
                            Text(snapshot.data!.email),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                            // Text(snapshot.data!.password),
                            // TextField(
                            //   controller: passwordController,
                            //   decoration: const InputDecoration(
                            //     hintText: 'password',
                            //   ),
                            // ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _updateUser = updatingUser(
                                        usernameController.text,
                                        emailController.text,
                                      );
                                    });
                                    Navigator.pushNamed(context, '/navBar');
                                  },
                                  child: const Text('Update Data'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
              // // SizedBox(
              // //   height: 30,
              // // ),
              // TextFormField(
              //   onChanged: (value) {
              //     usernameController.text = value;
              //     // emailTextController = value;
              //   },
              //   controller: usernameController,
              //   decoration: InputDecoration(
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.amber),
              //       ),
              //       hintText: "Username"),
              // ),
              // SizedBox(
              //   height: 35,
              // ),
              // TextFormField(
              //   onChanged: (value) {
              //     passwordController.text = value;
              //   },
              //   obscureText: true,
              //   controller: passwordController,
              //   decoration: InputDecoration(
              //     enabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     focusedBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.amber),
              //     ),
              //     hintText: "password",
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // TextFormField(
              //   onChanged: (value) {
              //     emailController.text = value;
              //     // emailTextController = value;
              //   },
              //   controller: emailController,
              //   decoration: InputDecoration(
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.amber),
              //       ),
              //       hintText: "email"),
              // ),
              // buildTextField("Username", "Dan", false),
              // buildTextField("New Password", "********", true),
              // buildTextField("Secret Key", "1234", false),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () => {
              //         _updateUser = updatingUser(usernameController.text,
              //             emailController.text, passwordController.text),
              //         Navigator.push(
              //           context,
              //           PageTransition(
              //             type: PageTransitionType.topToBottom,
              //             duration: Duration(milliseconds: 350),
              //             child: navBar(),
              //           ),
              //         )
              //       },
              //       child: Text(
              //         "Save",
              //         style: TextStyle(fontSize: 15, color: Colors.white),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         primary: Colors.amber,
              //         padding: EdgeInsets.symmetric(horizontal: 50),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //       ),
              //     ),
              //     OutlinedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           PageTransition(
              //             type: PageTransitionType.rightToLeft,
              //             duration: Duration(milliseconds: 350),
              //             child: navBar(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         "Cancel",
              //         style: TextStyle(fontSize: 15, color: Colors.amber),
              //       ),
              //       style: OutlinedButton.styleFrom(
              //           padding: EdgeInsets.symmetric(horizontal: 60),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30))),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildTextField(
  //     String labelText, String placeholder, bool isPaswordText) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 30),
  //     child: TextField(
  //       obscureText: isPaswordText ? isObscure : false,
  //       decoration: InputDecoration(
  //           suffixIcon: isPaswordText
  //               ? IconButton(
  //                   onPressed: () => {},
  //                   icon: Icon(
  //                     Icons.remove_red_eye_outlined,
  //                     color: Colors.amber,
  //                   ))
  //               : null,
  //           contentPadding: EdgeInsets.only(bottom: 5),
  //           labelText: labelText,
  //           floatingLabelBehavior: FloatingLabelBehavior.always,
  //           hintText: placeholder,
  //           hintStyle:
  //               TextStyle(fontSize: 16, color: Colors.amber.withOpacity(0.6))),
  //     ),
  //   );
  // }
}

Future<User> updatingUser(String username, String email) async {
  var url = "http://10.0.2.2:3000/api/users/update";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  print(token);
  final response = await http.put(
    Uri.parse(url),
    // headers: {
    //   HttpHeaders.authorizationHeader: token,
    // },
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token,
    },
    body: jsonEncode(<String, String>{
      'username': username,
      // 'password': password,
      'email': email
    }),
  );
  final responseJson = jsonDecode(response.body);
  print(responseJson);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update user.');
  }
}

Future<User> getCurrentUser() async {
  var url = "http://10.0.2.2:3000/api/users/current";
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
  if (response.statusCode == 200) {
    // List<User> results = [];
    print(responseJson[0]);
    // responseJson.forEach((val) => {results.add(User.fromJson(val))});
    // return results;
    return User.fromJson(jsonDecode(response.body));
    // return responseJson;
  } else {
    throw Exception("Failed to load AppEvent");
  }
}

Future<User> changePassword(String newPassword) async {
    var url = "http://10.0.2.2:3000/api/users/update";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  print(token);
  final response = await http.put(
    Uri.parse(url),
    // headers: {
    
    //   HttpHeaders.authorizationHeader: token,
    // },
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token,
    },
    body: jsonEncode(<String, String>{
      // 'password': newpassword,
      // // 'password': password,
      // 'email': email
      
    }),
  );
  final responseJson = jsonDecode(response.body);
  print(responseJson);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update user.');
  }

    
  }
