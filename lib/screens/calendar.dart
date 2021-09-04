import 'package:flutter/material.dart';

class calendarPage extends StatelessWidget {
  static const routename = "/calendar";
  const calendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Calender")),
      ),
    );
  }
}
