import 'package:flutter/material.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class TaskSent extends StatelessWidget {
  final GroundedTask task;
  final Child child;

  TaskSent({required this.child, required this.task});

  DateTime get _expectedCompletionDate =>
      DateTime.fromMillisecondsSinceEpoch(task.expectedCompletionTimestamp);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bubblePosition: BackgroundBubblePosition.topRight,
        appBar: CustomAppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(task.subjectType.value,
                  style: TextStyles.extraBold.copyWith(fontSize: 24)),
              SizedBox(height: 10),
              Text("Assigned to", style: TextStyles.semiBold),
              SizedBox(height: 30),
              UserImage(imageURL: child.profilePhoto, size: 130),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PNGIcon(icon: AppIcons.calendarPNG, size: 30),
                  SizedBox(width: 10),
                  Text(
                      "${_expectedCompletionDate.day} - ${_expectedCompletionDate.month} - ${_expectedCompletionDate.year}",
                      style: TextStyles.semiBold.copyWith(fontSize: 17)),
                  SizedBox(width: 70),
                  PNGIcon(icon: AppIcons.clockPNG, size: 30),
                  SizedBox(width: 10),
                  Text(
                      "${_expectedCompletionDate.hour} : ${_expectedCompletionDate.minute}",
                      style: TextStyles.semiBold.copyWith(fontSize: 17)),
                ],
              ),
              SizedBox(height: 50),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(120)),
                    color: ThemeColors.primary,
                  ),
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(35),
                  child: SVGIcon(
                      icon: AppIcons.send, color: ThemeColors.lightElement)),
              SizedBox(height: 20),
              Text("Task Sent Successfully 😊",
                  style: TextStyles.semiBold.copyWith(fontSize: 22)),
              SizedBox(height: 40),
              CustomActionButton(
                title: "Send Another Task",
                isRedButton: true,
                onPressed: () {
                  _closeTaskSentScreen(context, wantsToSendAnotherTask: true);
                },
              ),
              CustomActionButton(
                title: "Done",
                isRedButton: false,
                onPressed: () {
                  _closeTaskSentScreen(context);
                },
              )
            ],
          ),
        ));
  }

  void _closeTaskSentScreen(
    BuildContext context, {
    bool wantsToSendAnotherTask = false,
  }) {
    Navigator.pop(context, wantsToSendAnotherTask);
    if (wantsToSendAnotherTask) return;

    Navigator.pop(context);
  }
}
