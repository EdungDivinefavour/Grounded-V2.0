import 'package:flutter/material.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/services/audio/audio_player.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class TaskSent extends StatefulWidget {
  final GroundedTask task;
  final Child child;

  TaskSent({required this.child, required this.task});

  @override
  State<TaskSent> createState() => _TaskSentState();
}

class _TaskSentState extends State<TaskSent> {
  DateTime get _expectedCompletionDate => DateTime.fromMillisecondsSinceEpoch(
      widget.task.expectedCompletionTimestamp);

  @override
  void initState() {
    super.initState();

    AudioPlayer.instance.play(AudioTones.swoosh);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bubblePosition: BackgroundBubblePosition.topRight,
        appBar: CustomAppBar(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("${widget.task.name} (${widget.task.subjectType.value})",
                  style: TextStyles.extraBold),
              SizedBox(height: 15),
              Text("Assigned to", style: TextStyles.regular),
              SizedBox(height: 40),
              UserImage(imageURL: widget.child.profilePhoto, size: 90),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SVGIcon(icon: AppIcons.calendar, size: 30),
                  SizedBox(width: 10),
                  Text(
                      "${_expectedCompletionDate.day} - ${_expectedCompletionDate.month} - ${_expectedCompletionDate.year}",
                      style: TextStyles.regular.copyWith(fontSize: 14)),
                  SizedBox(width: 70),
                  SVGIcon(icon: AppIcons.clock, size: 30),
                  SizedBox(width: 10),
                  Text(
                      "${_expectedCompletionDate.hour} : ${_expectedCompletionDate.minute}",
                      style: TextStyles.regular.copyWith(fontSize: 14)),
                ],
              ),
              Spacer(),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(120)),
                    color: ThemeColors.primary,
                  ),
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.all(35),
                  child: SVGIcon(
                      icon: AppIcons.send, color: ThemeColors.lightElement)),
              SizedBox(height: 20),
              Text("Task Sent Successfully 😊", style: TextStyles.semiBold),
              SizedBox(height: 100),
              CustomActionButton(
                title: "Done",
                isRedButton: true,
                onPressed: () {
                  _closeTaskSentScreen(context);
                },
              )
            ],
          ),
        ));
  }

  void _closeTaskSentScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
