import 'package:flutter/material.dart';
import 'package:ketero_app/screens/calendar.dart';
import 'package:ketero_app/screens/homepage.dart';
import 'package:ketero_app/screens/newAppoint.dart';
import 'package:ketero_app/screens/user_profile.dart';
import 'package:page_transition/page_transition.dart';

// ignore: camel_case_types
class navBar extends StatefulWidget {
  static const routeName = "/navBar";
  navBar({Key? key}) : super(key: key);

  @override
  _navBarState createState() => _navBarState();
}

// ignore: camel_case_types
class _navBarState extends State<navBar> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': MyHomePage(),
        'title': 'Home',
      },
      {
        'page': newAppoint(),
        'title': 'New Appointment',
      },
      {
        'page': UserProfile(),
        'title': 'Profile',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "KETERO",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        backgroundColor: Colors.brown,
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
                        child: calendarPage(),
                      ),
                    )
                  },
              icon: Icon(
                Icons.calendar_today,
                color: Colors.amber,
              ))
        ],
      ),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Appoint",
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "Profile",
              backgroundColor: Colors.amber),
        ],
      ),
    );
  }
}
