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
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 220,
              width: double.maxFinite,
              child: Card(
                color: Colors.amberAccent,
                elevation: 2,
                child: Row(
                  children: [
                    Container(
                      width: 260,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                          Text(
                            "This is a description of the appointment that you need to be making so to do that there might be some kind of thing to do this will not hurt the  ",
                            style: TextStyle(
                                color: Colors.brown.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Text("Time left")
                  ],
                ),
              ),
            );
          }),
    );
  }
}
