import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:ketero_app/bloc/auth_bloc.dart';
import 'package:ketero_app/bloc/bloc-event.dart';
// import 'package:ketero_app/bloc/event_bloc.dart';
import 'package:ketero_app/bloc/task_bloc.dart';
import 'package:ketero_app/model/classes/appevent.dart';

import 'package:ketero_app/screens/calendar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddEvent extends StatefulWidget {
  final DateTime? selectedDate;
  AddEvent({Key? key, this.selectedDate}) : super(key: key);
  AppEvent appEvent = AppEvent(
      title: "", description: "", target_date: DateTime.now());

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        centerTitle: true,
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                final authBlocEvent = AuthBlocEvent();
                authBlocEvent.add(AddEvents(
                    title: titleController.text,
                    description: descController.text,
                    targeted_date: DateTime.now()));
                // postTask(a, description, targeted_date);
                bool validated = _formKey.currentState!.validate();
                if (validated) {
                  _formKey.currentState!.save();
                  // store the data to the database
                  // final data =
                  //     Map<String, dynamic>.from(_formKey.currentState!.value);
                  // this where the new event will be stored in  database;
                  // postTask(, description, targeted_date)
                  Navigator.of(context).pop();
                  // print(data);
                }
              },
              child: Text("Save"),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  controller: titleController,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  name: 'title',
                  decoration: InputDecoration(
                    icon: Icon(Icons.edit_outlined),
                    border: InputBorder.none,
                    hintText: "Add Title",
                    contentPadding: EdgeInsets.only(left: 48),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  controller: descController,
                  name: 'description',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Details",
                    prefixIcon: Icon(Icons.short_text),
                    // contentPadding: EdgeInsets.only(left: 48),
                  ),
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  name: 'date',
                  initialValue: widget.selectedDate ?? DateTime.now(),
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: "Add Title",
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                    // contentPadding: EdgeInsets.only(left: 48),
                  ),
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  name: 'date',
                  initialValue: widget.selectedDate ?? DateTime.now(),
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: "Add Title",
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                    // contentPadding: EdgeInsets.only(left: 48),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// AddEventToDataBase(email, password) async {
//   var url = "http://10.0.2.2:3000/api/tasks";
//   final response = await http.post(
//     Uri.parse(url),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );
//   if (response.statusCode == 200) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var parse = jsonDecode(response.body);
//     // print(parse["token"]);
//     await prefs.setString('token', parse['token']);
//     String token = prefs.getString('token').toString();
//     print(token);
//     // print();
//     return parse;
//   } else {
//     return Text('404');
//   }
// }

// posting method

// postTask(title, description, targeted_date) async {
//   var url = "http://10.0.2.2:3000/api/tasks";
//   // var parse = jsonDecode(response.body);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString('token')!;
//   final response = await http.post(
//     Uri.parse(url),
//     // Send authorization headers to the backend.
//     headers: {
//       HttpHeaders.authorizationHeader: token,
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//       'description': description,
//       'targeted_date': targeted_date,
//     }),
//   );
//   if (response.statusCode == 201) {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     var parse = jsonDecode(response.body);
//     return parse;
//   } else {
//     return Text('201');
//   }
//   // final responseJson = jsonDecode(response.body);
//   // print(responseJson);
//   // return responseJson;
// }
