import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/child/solve_task.dart';
import 'package:grounded/services/firebase/firestore_service.dart';

class HomeChild extends StatefulWidget {
  final Child child;
  const HomeChild({required this.child});

  @override
  State<HomeChild> createState() => _HomeChildState();
}

class _HomeChildState extends State<HomeChild> {
  final _firestoreService = FirestoreService.instance;

  List<GroundedTask> _tasks = [];

  @override
  void initState() {
    super.initState();

    _getChildTasks();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        Container(),
      ],
    ));
  }

  // TODO: Call this widget when you need the list of achievements
  Widget _buildTasksList() {
    return SizedBox(
      child: _tasks.isEmpty
          ? Text("No tasks yet!. Your parents haven't assigned any to you")
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _tasks.length,
              itemBuilder: (_, index) {
                return _buildEachTask(_tasks[index]);
              }),
    );
  }

// TODO: Build each task here
  Widget _buildEachTask(GroundedTask task) {
    return Container();
  }

  void _getChildTasks() async {
    final res = await _firestoreService.getTasksForChild(widget.child);

    setState(() {
      _tasks = res;
    });
  }

  void _openSolveTaskScreen(GroundedTask task) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SolveTask(task: task)));
  }
}
