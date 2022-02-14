import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';

class SolveTask extends StatefulWidget {
  final GroundedTask task;
  const SolveTask({required this.task});

  @override
  State<SolveTask> createState() => _SolveTaskState();
}

class _SolveTaskState extends State<SolveTask> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bubblePosition: BackgroundBubblePosition.centerRight,
        body: Container());
  }
}
