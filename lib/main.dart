// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/screens/appointments.dart';
import 'package:ketero_app/screens/homepage.dart';
import 'package:ketero_app/screens/signup.dart';
import 'package:ketero_app/screens/splashScreen.dart';
import 'package:ketero_app/screens/user_page.dart';

import 'package:ketero_app/screens/login.dart';
import 'package:ketero_app/screens/user_profile.dart';
import 'package:ketero_app/widget/addevent.dart';
import 'package:ketero_app/widget/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (ctx) => AuthBloc())],
      child: MaterialApp(
        initialRoute: LoginScreen.routename,
        routes: {
          '/navBar': (context) => navBar(),
          '/userprofile': (context) => UserProfile(),
          '/user': (context) => UserPage(),
          '/login': (context) => LoginScreen(),
          '/signUp': (context) => SignUpScreen(),
          '/homepage': (context) => MyHomePage(),
          '/newAppoint': (context) => newAppoint(),
          '/splash': (context) => splashScreen(),
          '/addEvent': (context) => AddEvent(),
        },
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
      ),
    );
  }
}
