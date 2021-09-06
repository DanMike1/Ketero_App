import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final DateTime? selectedDate;
  const AddEvent({Key? key, this.selectedDate}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Add Event"),
        centerTitle: true,
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                bool validated = _formKey.currentState!.validate();
                if (validated) {
                  _formKey.currentState!.save();
                  // store the data to the database
                  final data =
                      Map<String, dynamic>.from(_formKey.currentState!.value);
                  // this where the new event will be stored in  database;
                  Navigator.of(context).pop(data);
                  // print(data);
                }
                // print(validated);
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
