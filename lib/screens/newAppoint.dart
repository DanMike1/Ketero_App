import 'package:flutter/material.dart';

// ignore: camel_case_types
class newAppoint extends StatelessWidget {
  const newAppoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Add Task",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Column(
                children: [
                  Text("Task Name"),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: new TextStyle(fontSize: 17),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0))),
                      prefixIcon: Icon(Icons.work),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: new TextStyle(fontSize: 17),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0))),
                      prefixIcon: Icon(Icons.edit),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
