// import 'package:app/add_event.dart';
// import 'package:app/event.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ketero_app/model/classes/appevent.dart';
import 'package:ketero_app/model/classes/event.dart';
import 'package:ketero_app/widget/addevent.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<Event>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    return selectedEvents?[date] ?? [];
  }

  List vals = [];
  @override
  Widget build(BuildContext context) {
    // Map data = {}l
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              weekendDays: [6],
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDate,
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.saturday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDate, DateTime foucsDay) {
                setState(() {
                  selectedDate = selectDate;
                  focusedDate = foucsDay;
                });
                print(focusedDate);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDate, date);
              },
              eventLoader: _getEventsFromDay,
              calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(5.0),
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(5.0),
                  ),
                  defaultDecoration: BoxDecoration(shape: BoxShape.circle),
                  weekendDecoration: BoxDecoration(shape: BoxShape.circle)),
              headerStyle: HeaderStyle(
                // decoration: BoxDecoration(color: Colors.purple),
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
              ),
            ),
            ..._getEventsFromDay(selectedDate).map(
              (Event event) => ListTile(
                title: Text(
                  event.title.toString(),
                ),
              ),
            ),
            // StreamBuilder(
            //   // stream: AppEvent.streamList(context),
            //   // initialData: initialData,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.hasData) {
            //       // final data =
            //       // ModalRoute.of(context)?.settings.arguments as Map;

            //       // final events = data;
            //       ListView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: vals.length,
            //           itemBuilder: (itemBuilder, index) {
            //             AppEvent event = vals[index];
            //             return ListTile(
            //               title: Text(event.title),
            //             );
            //           });
            //       // print(data);
            //     }
            //     return CircularProgressIndicator();
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  // color: Colors.amber,
                  height: 900,
                  width: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: vals.length,
                      itemBuilder: (itemBuilder, index) {
                        print(vals);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              child: Text(vals[index]['title']),
                            ),
                            Card(
                              child: Text(vals[index]['date'].toString()),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("title"),
      //       content: TextFormField(
      //         controller: _eventController,
      //       ),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: Text('Cancel'),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             if (_eventController.text.isEmpty) {
      //               // Navigator.pop(context);
      //               // return;
      //             } else {
      //               if (selectedEvents?[selectedDate] != null) {
      //                 selectedEvents?[selectedDate]!.add(
      //                   Event(title: _eventController.text),
      //                 );
      //               } else {
      //                 selectedEvents?[selectedDate] = [
      //                   Event(title: _eventController.text)
      //                 ];
      //               }
      //             }
      //             Navigator.pop(context);
      //             _eventController.clear();
      //             setState(() {});
      //             return;
      //           },
      //           child: Text('Save'),
      //         ),
      //       ],
      //     ),
      //   ),
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/addEvent', arguments: selectedDate);
          Navigator.of(context)
              .push(
            MaterialPageRoute(
                builder: (context) => AddEvent(
                      selectedDate: selectedDate,
                    )),
          )
              .then((value) {
            setState(() {
              if (value != null) {
                // fetchEvent("sina", 'description', "2021,09,02");

                vals.add(value);
              }
            });
            // final decode = jsonDecode(value);
            print('============value');
            print(value);
            // return value;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
