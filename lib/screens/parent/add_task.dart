import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/constants/enums/question_type.dart';
import 'package:grounded/models/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/services/firebase/firestore_service.dart';

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

  DateTime? compiledDateAndTime;

  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  Future<void> _openDatePicker() async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));
    if (pickedDate == null) return;

    setState(() {
      _expectedCompletionDateController.text =
          "${pickedDate!.day} - ${pickedDate!.month} - ${pickedDate!.year}";
    });
  }

  Future<void> _openTimePicker() async {
    if (pickedDate == null) {
      EasyLoading.showError("Please pick a date first");
      return;
    }

    pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );

    if (pickedTime == null) return;
    compiledDateAndTime = DateTime(
      pickedDate!.year,
      pickedDate!.month,
      pickedDate!.day,
      pickedTime!.hour,
      pickedTime!.minute,
    );

    setState(() {
      _expectedCompletionTimeController.text =
          "${pickedTime!.hour} : ${pickedTime!.minute}";
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
      questionTypeToCreate: _subjectController.text.toQuestionType,
      expectedCompletionTimestamp: compiledDateAndTime!.millisecondsSinceEpoch,
    );

    await _firestoreService.storeTask(task: task);
    await EasyLoading.showSuccess(
        "Task assigned created and assigned to ${widget.child.name}");

    Navigator.pop(context);
  }

  bool get _allFieldsPassedValidation {
    if (_taskNameController.text == "") {
      return false;
    } else if (_subjectController.text == "") {
      return false;
    } else if (_expectedCompletionDateController.text == "") {
      return false;
    } else if (_expectedCompletionTimeController.text == "") {
      return false;
    }

    return true;
  }
}
