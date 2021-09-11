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
import 'package:ketero_app/screens/homepage.dart';
import 'package:ketero_app/widget/navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navAddEvents extends StatefulWidget {
  final DateTime? selectedDate;
  navAddEvents({Key? key, this.selectedDate}) : super(key: key);
  AppEvent appEvent =
      AppEvent(title: "", description: "", target_date: DateTime.now());

  @override
  _navAddEventsState createState() => _navAddEventsState();
}

class _navAddEventsState extends State<navAddEvents> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 20),
                ElevatedButton(
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
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 350),
                          child: navBar(),
                        ),
                      );
                      // print(data);
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
