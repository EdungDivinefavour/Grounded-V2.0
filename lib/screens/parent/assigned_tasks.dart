import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/center_text.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/constants/enums/math_sub_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/question/question.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/local_storage/local_storage.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AssignedTask extends StatefulWidget {
  @override
  State<AssignedTask> createState() => _AssignedTaskState();
}

class _AssignedTaskState extends State<AssignedTask> {
  Parent? _parent;

  final _localStorage = LocalStorage.instance;
  final _firestoreService = FirestoreService.instance;

  List<GroundedTask>? _tasks;
  List<Child> _children = [];

  @override
  void initState() {
    super.initState();

    _getParentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Assigned Tasks"),
      bubblePosition: BackgroundBubblePosition.topRight,
      body: _tasks == null
          ? CenterText(text: "No tasks fetched")
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _tasks!.length,
                  itemBuilder: (_, index) {
                    return _buildEachTask(_tasks![index]);
                  }),
            ),
    );
  }

  Widget _buildEachTask(GroundedTask task) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        collapsedTextColor: ThemeColors.darkElement,
        textColor: ThemeColors.lightElement,
        collapsedBackgroundColor: ThemeColors.lightElement,
        backgroundColor: ThemeColors.primaryDark,
        collapsedIconColor: ThemeColors.darkElement,
        iconColor: ThemeColors.lightElement,
        title: Row(
          children: [
            Text(
              '${task.name} (${task.subjectType.value})',
              style: TextStyles.semiBold,
            ),
            SizedBox(width: 10),
            SVGIcon(
                icon: AppIcons.checkOutline,
                size: 25,
                color: ThemeColors.primary),
          ],
        ),
        children: task.questions.map((x) => _buildEachQuestion(x)).toList(),
      ),
    );
  }

  Widget _buildEachQuestion(Question question) {
    final style = TextStyles.regular.copyWith(color: ThemeColors.darkElement);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 70,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              question.englishSubType != null
                  ? Text('Question type: ${question.englishSubType!.value}',
                      style: style)
                  : emptyWidget,
              question.mathSubType != null
                  ? Text('Question type: ${question.mathSubType!.value}',
                      style: style)
                  : emptyWidget,
              Text('Question: ${question.displayedQuestion}', style: style),
              Text(
                  'Picked Answer: ${question.pickedAnswer ?? 'No answer picked yet'}',
                  style: style),
              Text('Correct Answer: ${question.correctAnswer}', style: style),
              question.timeSpentOnQuestion != 0
                  ? Text(
                      'Time spent on question: ${question.timeSpentOnQuestion}(seconds)',
                      style: style)
                  : emptyWidget,
              question.subjectType == SubjectType.english
                  ? Text('Suggested Answers: ${question.suggestedAnswers}',
                      style: style)
                  : emptyWidget,
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  void _getAllChildren() async {
    _children = await _firestoreService.getChildrenForParent(_parent!);
    final allTasks = <GroundedTask>[];
    _tasks = [];

    for (final child in _children) {
      allTasks.addAll(child.tasks);
    }

    setState(() {
      _tasks?.addAll(allTasks);
    });
    EasyLoading.dismiss();
  }

  void _getParentInfo() async {
    EasyLoading.show();
    final result = await _localStorage.getUserInfoFromLocal();

    setState(() => _parent = result as Parent);
    _getAllChildren();
  }
}
