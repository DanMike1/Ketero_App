import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/screens/homepage.dart';
import 'package:ketero_app/screens/user_page.dart';

import 'package:ketero_app/screens/login.dart';

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
          '/login': (context) => LoginScreen(),
          '/home': (context) => MyHomePage(),
          '/user': (context) => UserPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
