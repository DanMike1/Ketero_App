import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 4, color: Colors.amber.withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: Colors.amber.withOpacity(0.2))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.pexels.com/photos/2701660/pexels-photo-2701660.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"))),
        ),
      ]),
    );
  }
}
