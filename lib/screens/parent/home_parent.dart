import 'package:flutter/material.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/add_task.dart';

class HomeParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void _openAddTaskScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask()));
  }

  void _openAddChildScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddChild()));
  }
}
