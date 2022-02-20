import 'package:flutter/material.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/constants/enums/question_category.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/screens/child/solve_task_english.dart';
import 'package:grounded/screens/child/solve_task_maths.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
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
            SizedBox(height: 30),
            Container(
              color: Colors.amber,
              margin: EdgeInsets.fromLTRB(2, 2, 0, 2),
              height: 200,
              width: 150,
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('English Language', style: TextStyles.smallBold),
                  SizedBox(height: 10),
                  PNGIcon(size: 60, icon: AppIcons.logoPNG),
                  Spacer(),
                  Container(
                      height: 30,
                      width: 150,
                      color: ThemeColors.primary,
                      alignment: Alignment.center,
                      child: Text(
                        "Continue",
                        style:
                            TextStyles.smallBold.copyWith(color: Colors.white),
                      )),
                ],
              ),
            ),
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
    final taskScreen = task.questionCategoryToCreate == QuestionCategory.maths
        ? SolveTaskMaths()
        : SolveTaskEnglish();

    Navigator.push(context, MaterialPageRoute(builder: (_) => taskScreen));
  }
}
