import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ketero_app/model/classes/user.dart';
import 'package:ketero_app/screens/login.dart';
import 'package:ketero_app/screens/user_page.dart';
import 'package:page_transition/page_transition.dart';
import '../widget/profile_pic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  static const String routename = "/userprofile";
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<User> user;
  @override
  void initState() {
    super.initState();
    user = getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // color: Colors.amber,
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePic(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ElevatedButton(
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 350),
                                      child: UserPage(),
                                    ),
                                  )
                                },
                            child: Text(
                              "Edit Profile",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(fontSize: 21),
                              ),
                              SizedBox(height: 7),
                              FutureBuilder<User>(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        height: 50,
                                        child: Text(
                                          snapshot.data!.username.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  }),
                              Text(
                                "Your Email",
                                style: TextStyle(fontSize: 21),
                              ),
                              SizedBox(height: 7),
                              FutureBuilder<User>(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        height: 25,
                                        child: Text(
                                          snapshot.data!.email.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('token');

                    Navigator.of(context).pushNamed(LoginScreen.routename);
                  },
                  child: Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
