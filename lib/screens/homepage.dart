import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
import 'package:ketero_app/model/classes/appevent.dart';
import 'package:ketero_app/widget/addevent.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static const routename = "/homepage";
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<AppEvent>> allEvents;
  @override
  @override
  void initState() {
    super.initState();
    allEvents = getFetchedEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<List<AppEvent>>(
              future: allEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ...snapshot.data!.map((e) {
                        return Text(e.title);
                      }).toList()
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ],
      ),
      // body: ListView.builder(
      //     itemCount: 10,
      //     itemBuilder: (BuildContext context, index) {
      //       return Container(
      //         padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
      //         child: Card(
      //           elevation: 10,
      //           child: Container(
      //             height: MediaQuery.of(context).size.height * 0.18,
      //             width: double.infinity,
      //             margin: EdgeInsets.all(5),
      //             decoration: BoxDecoration(
      //               // color: Colors.blueAccent[100],
      //               borderRadius: BorderRadius.circular(50),
      //             ),
      //             child: Stack(
      //               children: [
      //                 Container(
      //                   height: MediaQuery.of(context).size.height * 0.18,
      //                   width: double.infinity,
      //                   margin: EdgeInsets.all(5),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                         padding: EdgeInsets.symmetric(
      //                             vertical: 10, horizontal: 7),
      //                         child: Text(
      //                           'Work Appointment',
      //                           style: TextStyle(
      //                             fontSize: 19,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 320,
      //                         padding: EdgeInsets.symmetric(
      //                           horizontal: 20,
      //                           vertical: 4,
      //                         ),
      //                         child: Text(
      //                           'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
      //                           overflow: TextOverflow.ellipsis,
      //                           maxLines: 5,
      //                           textAlign: TextAlign.justify,
      //                           style: TextStyle(),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.bottomRight,
      //                   child: GestureDetector(
      //                     child: Container(
      //                       height: 30,
      //                       width: 30,
      //                       decoration: BoxDecoration(
      //                           color: Colors.red,
      //                           borderRadius: BorderRadius.circular(80)),
      //                       margin: EdgeInsets.all(10),
      //                       child: Icon(
      //                         Icons.delete,
      //                         size: 20,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Align(
      //                   alignment: Alignment.topRight,
      //                   child: Container(
      //                     width: 80,
      //                     decoration: BoxDecoration(
      //                         color: Colors.grey[800],
      //                         borderRadius: BorderRadius.circular(20)),
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: 10, horizontal: 10),
      //                     margin:
      //                         EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //                     child: Text(''),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
    );
  }
}

//! GET ALL TASKs
Future<List<AppEvent>> getFetchedEvent() async {
  var url = "http://10.0.2.2:3000/api/tasks";
  // var parse = jsonDecode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  final response = await http.get(
    Uri.parse(url),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: token,
    },
  );
  final responseJson = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (responseJson == null) {
       throw Exception("no task inputted yet");
    }
    List<AppEvent> results = [];
    // print(responseJson[0]);
    responseJson.forEach((val) => {results.add(AppEvent.fromJson(val))});
    return results;
  } else {
    throw Exception("Failed to load AppEvent");
  }
}

// {'a':[]}

