// import 'package:flutter/material.dart';
// import '../widget/listCard.dart';
// import '../model/classes/task.dart';
// import '../model/global.dart';
// // import 'package:http/http.dart' as http;

// class ListViews extends StatefulWidget {
//   ListViews({Key? key}) : super(key: key);

//   @override
//   _ListViewState createState() => _ListViewState();
// }

// class _ListViewState extends State<ListViews> {
//   List<Task> appoint = [];
//   @override
//   Widget build(BuildContext context) {
//     appoint = getList();
//     return Container(
//       // padding: EdgeInsets.only(top: 200),
//       color: darkGreyColor,
//       child: _buildReorderableListSimple(context),
//       // child: ReorderableListView(
//       //   padding: EdgeInsets.only(top: 300),
//       //   children: getList(),
//       //   onReorder: _onReorder,
//       // ),
//     );
//   }

//   Widget _buildListTitle(BuildContext context, Task item) {
//     return ListTile(
//       key: Key(item.taskId),
//       title: Listcard(
//         title: item.title,
//         // keyValue: item.taskId,
//       ),
//     );
//   }

//   Widget _buildReorderableListSimple(BuildContext context) {
//     return Theme(
//       data: ThemeData(canvasColor: darkGreyColor),
//       child: ReorderableListView(
//         padding: EdgeInsets.only(top: 300),
//         children:
//             appoint.map((Task item) => _buildListTitle(context, item)).toList(),
//         // onReorder: (oldIndex, newIndex) {
//         //   setState(() {
//         //     Task item = appoint.removeAt(oldIndex);
//         //     // appoint.remove(item);
//         //     appoint.insert(newIndex, item);
//         //   });
//         // },
//         onReorder: _onReorder,
//       ),
//     );
//   }

//   void _onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final Task item = appoint.removeAt(oldIndex);
//       appoint.insert(newIndex, item);
//     });
//   }

//   List<Task> getList() {
//     for (var i = 0; i < 10; i++) {
//       appoint.add(
//         Task(
//           title: 'title' + i.toString(),
//           completed: false,
//           taskId: i.toString(),
//         ),
//       );
//     }
//     return appoint;
//   }
// }
