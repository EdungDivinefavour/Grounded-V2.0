import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class SolveTaskEnglish extends StatefulWidget {
  final GroundedTask task;
  SolveTaskEnglish({required this.task});

  @override
  State<SolveTaskEnglish> createState() => _SolveTaskEnglishState();
}

class _SolveTaskEnglishState extends State<SolveTaskEnglish> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(),
        bubblePosition: BackgroundBubblePosition.centerRight,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
        ));
  }
}
