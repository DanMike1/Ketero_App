import 'package:flutter/material.dart';
import './listview.dart';
import '../model/global.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Stack(
              children: [
                TabBarView(
                  children: [
                    ListViews(),
                    Container(
                      color: Colors.orange,
                    ),
                    Container(
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment',
                        style: AppointmentTitleStyle,
                      ),
                      Container(),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.fromLTRB(170, 150, 0, 0),
                  child: FloatingActionButton(
                    // elevation: 20,
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      size: 60,
                    ),
                    backgroundColor: greenColor,
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: appBarColor,
              title: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.calendar_today),
                  ),
                  Tab(
                    icon: Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
            ),
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
