import 'package:flutter/material.dart';
import '../model/global.dart';

class Listcard extends StatelessWidget {
  final String title;
  String? keyValue;

  Listcard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      // margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 100,
      child: Row(
        children: [
          Radio(
            value: 2,
            groupValue: 0,
            onChanged: (value) {},
            activeColor: Colors.red,
          ),
          Column(
            children: [
              Text(
                '$title',
                style: AppointmentDarkTitleStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
