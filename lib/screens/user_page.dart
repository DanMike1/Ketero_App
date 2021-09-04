import 'package:flutter/material.dart';
import 'package:ketero_app/screens/calendar.dart';
import 'package:ketero_app/screens/user_profile.dart';
import 'package:ketero_app/widget/profile_pic.dart';
import 'package:page_transition/page_transition.dart';

class UserPage extends StatelessWidget {
  static const String routename = "/user";
  final bool isObscure = true;
  const UserPage({Key? key}) : super(key: key);
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
              SizedBox(
                height: 30,
              ),
              buildTextField("Username", "Dan", false),
              buildTextField("New Password", "********", true),
              buildTextField("Secret Key", "1234", false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.topToBottom,
                                duration: Duration(milliseconds: 350),
                                child: UserProfile(),
                              ),
                            )
                          },
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 350),
                          child: UserProfile(),
                        ),
                      );
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15, color: Colors.amber),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPaswordText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPaswordText ? isObscure : false,
        decoration: InputDecoration(
            suffixIcon: isPaswordText
                ? IconButton(
                    onPressed: () => {},
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.amber,
                    ))
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle:
                TextStyle(fontSize: 16, color: Colors.amber.withOpacity(0.6))),
      ),
    );
  }
}
