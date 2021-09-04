import 'package:flutter/material.dart';
import 'package:ketero_app/screens/calendar.dart';
import 'package:ketero_app/screens/user_page.dart';
import 'package:page_transition/page_transition.dart';
import '../widget/profile_pic.dart';

class UserProfile extends StatelessWidget {
  static const String routename = "/userprofile";
  const UserProfile({Key? key}) : super(key: key);

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
      body: Container(
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
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "Dan Mekonnen",
                            style: TextStyle(
                                fontSize: 20, color: Colors.amberAccent),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "First Name",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "Dan Mekonnen",
                            style: TextStyle(
                                fontSize: 20, color: Colors.amberAccent),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Last Name",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "Dan Mekonnen",
                            style: TextStyle(
                                fontSize: 20, color: Colors.amberAccent),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    FittedBox(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Number of appointments",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "60",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.amberAccent),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Appointments Pending",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.amber),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
