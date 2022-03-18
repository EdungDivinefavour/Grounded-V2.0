import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/task_sent.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AddTask extends StatefulWidget {
  final Parent parent;
  final Child child;

  const AddTask({required this.parent, required this.child});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _firestoreService = FirestoreService.instance;

  final _taskNameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _expectedCompletionDateController = TextEditingController();
  final _expectedCompletionTimeController = TextEditingController();

  final _mathTypeController = TextEditingController();

  DateTime? compiledDateAndTime;

  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  SubjectType? _selectedSubjectType;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(title: "Add New Task"),
        bubblePosition: BackgroundBubblePosition.topRight,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 900,
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        UserImage(
                            imageURL: widget.child.profilePhoto, size: 60),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.child.name,
                                    style: TextStyles.semiBold),
                                SizedBox(width: 5),
                                Text("(${widget.child.age} years old)")
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("Grade ${widget.child.grade}"),
                            SizedBox(height: 10),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 30),
                InputField(
                  title: "Task Name",
                  hintText: "Enter the name of the task",
                  controller: _taskNameController,
                ),
                SizedBox(height: 30),
                InputField(
                  title: "Subject",
                  hintText: "Click to display dropdown of subjects",
                  dropDownList: [
                    SubjectType.maths.value,
                    SubjectType.english.value
                  ],
                  onDropDownChange: (value) {
                    setState(() {
                      _selectedSubjectType = value!.toSubjectType;
                      _subjectController.text = value;
                    });
                  },
                  controller: _subjectController,
                ),
                _selectedSubjectType == SubjectType.maths
                    ? SizedBox(height: 30)
                    : emptyWidget,
                _selectedSubjectType == SubjectType.maths
                    ? InputField(
                        title: "Type",
                        hintText: "Click to display dropdown of math types",
                        dropDownList: [
                          MathType.addition.value,
                          MathType.subtraction.value,
                          MathType.multiplication.value,
                          MathType.division.value,
                        ],
                        onDropDownChange: (value) {
                          _mathTypeController.text = value!;
                        },
                        controller: _mathTypeController,
                      )
                    : emptyWidget,
                SizedBox(height: 30),
                InputField(
                  title: "Expected completion date",
                  hintText: "Click here to pick a date",
                  leftIcon: AppIcons.calendar,
                  controller: _expectedCompletionDateController,
                  onTap: _openDatePicker,
                ),
                SizedBox(height: 30),
                InputField(
                  title: "Expected completion time",
                  hintText: "Click here to pick a time",
                  leftIcon: AppIcons.clock,
                  controller: _expectedCompletionTimeController,
                  onTap: _openTimePicker,
                ),
                SizedBox(height: 60),
                CustomActionButton(
                    onPressed: _addTask, title: "Send Task", isRedButton: true),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  void _openDatePicker() async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));
    if (_pickedDate == null) return;

    setState(() {
      _expectedCompletionDateController.text =
          "${_pickedDate!.day} - ${_pickedDate!.month} - ${_pickedDate!.year}";
    });
  }

  void _openTimePicker() async {
    if (_pickedDate == null) {
      EasyLoading.showError("Please pick a date first");
      return;
    }

    _pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );

    if (_pickedTime == null) return;
    compiledDateAndTime = DateTime(
      _pickedDate!.year,
      _pickedDate!.month,
      _pickedDate!.day,
      _pickedDate!.hour,
      _pickedDate!.minute,
    );

    setState(() {
      _expectedCompletionTimeController.text =
          "${_pickedTime!.hour} : ${_pickedTime!.minute}";
    });
  }

  void _addTask() async {
    if (!_allFieldsPassedValidation) {
      EasyLoading.showError("Please fill out all the empty fields to proceed");
      return;
    }
    EasyLoading.show();
    final task = GroundedTask.newTask(
      name: _taskNameController.text,
      parentID: widget.parent.id,
      childID: widget.child.id,
      subjectType: _subjectController.text.toSubjectType,
      mathTypeToCreate:
          _subjectController.text.toSubjectType == SubjectType.maths
              ? _mathTypeController.text.toMathType
              : null,
      englishTypeToCreate:
          _subjectController.text.toSubjectType == SubjectType.maths
              ? null
              : EnglishType.general,
      expectedCompletionTimestamp: compiledDateAndTime!.millisecondsSinceEpoch,
    );

    await _firestoreService.storeTask(task: task, child: widget.child);
    EasyLoading.dismiss();

    _openTaskSentScreen(task);
  }

  void _openTaskSentScreen(GroundedTask task) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                TaskSent(child: widget.child, task: task)));
  }

  bool get _allFieldsPassedValidation {
    if (_taskNameController.text == "") {
      return false;
    } else if (_subjectController.text == "") {
      return false;
    } else if (_subjectController.text == SubjectType.maths.value &&
        _mathTypeController.text == "") {
      return false;
    } else if (_expectedCompletionDateController.text == "") {
      return false;
    } else if (_expectedCompletionTimeController.text == "") {
      return false;
    }

    return true;
  }
}
