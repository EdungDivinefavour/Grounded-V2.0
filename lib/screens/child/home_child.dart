import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/child/solve_task.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';

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
      appBar: CustomAppBar(hasDrawer: true),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            ScreenTitle(
                title: "Hey " + shortenToFirstOnly(widget.child.name),
                isWhiteBackround: true),
            Row(
              children: [
                Icon(Icons.list_outlined),
                Spacer(),
                Icon(Icons.notifications)
              ],
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hey Sarah!",
                style: TextStyles.extraBold.copyWith(fontSize: 24),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ready to make your parents proud today?",
                style: TextStyles.regular,
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pending Tasks",
                style: TextStyles.extraBold.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 20)
          ])),
    );
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
