import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/child/solve_task_english.dart';
import 'package:grounded/screens/child/solve_task_maths.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
      bubblePosition: BackgroundBubblePosition.bottomLeft,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              ScreenTitle(
                  title: "Hey " + shortenToFirstOnly(widget.child.name),
                  subTitle: "Ready to make your parents proud today?",
                  isWhiteBackround: true),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pending Tasks",
                  style: TextStyles.extraBold.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              _buildTasksList(),
            ])),
      ),
    );
  }

  Widget _buildTasksList() {
    return SizedBox(
      height: 2000,
      child: _tasks.isEmpty
          ? Text("No tasks yet!. Your parents haven't assigned any to you")
          : GridView.builder(
              itemCount: _tasks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (_, index) {
                return _buildEachTask(_tasks[index]);
              }),
    );
  }

  Widget _buildEachTask(GroundedTask task) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: ThemeColors.lightBackground,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
              task.subjectType == SubjectType.english
                  ? task.subjectType.value
                  : task.questions[0].mathType!.value,
              style: TextStyles.smallBold),
          SizedBox(height: 15),
          PNGIcon(size: 70, icon: task.taskIcon),
          SizedBox(height: 12),
          LinearPercentIndicator(
            barRadius: Radius.circular(5),
            lineHeight: 8.0,
            percent: task.completedPercentage / 100,
            progressColor: ThemeColors.primary,
            backgroundColor: ThemeColors.primaryLight,
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("${task.completedPercentage.toInt()}%",
                  style: TextStyles.smallBold),
            ),
          ),
          Spacer(),
          _buildContinueButton(task),
        ],
      ),
    );
  }

  Widget _buildContinueButton(GroundedTask task) {
    return InkWell(
      onTap: () {
        task.hasBeenCompleted ? null : _openSolveTaskScreen(task);
      },
      child: Container(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: task.hasBeenCompleted
                ? ThemeColors.primaryLight
                : ThemeColors.primary,
          ),
          alignment: Alignment.center,
          child: Text(
            "Continue",
            style: TextStyles.smallBold.copyWith(color: Colors.white),
          )),
    );
  }

  void _getChildTasks() async {
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 3));

    EasyLoading.dismiss();
    setState(() {
      _tasks = widget.child.tasks;
    });
  }

  void _openSolveTaskScreen(GroundedTask task) async {
    final taskScreen = task.subjectType == SubjectType.maths
        ? SolveTaskMaths(task: task)
        : SolveTaskEnglish(task: task);

    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => taskScreen));
    setState(() {});

    _updateTasks();
  }

  void _updateTasks() async {
    EasyLoading.show();
    await _firestoreService.updateTasks(
        tasks: widget.child.tasks, child: widget.child);

    await _firestoreService.updateTasks(
        tasks: widget.child.tasks, child: widget.child);

    EasyLoading.dismiss();
    EasyLoading.showSuccess("Progress saved");
  }
}
