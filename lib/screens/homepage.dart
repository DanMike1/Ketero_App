import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import './listview.dart';
import '../model/global.dart';
import 'calendar.dart';

class MyHomePage extends StatefulWidget {
  static const routename = "/homepage";
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("body")],
      ),
    );
  }
}
