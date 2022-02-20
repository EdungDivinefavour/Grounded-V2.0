import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class SolveTaskMaths extends StatefulWidget {
  @override
  State<SolveTaskMaths> createState() => _SolveTaskMathsState();
}

class _SolveTaskMathsState extends State<SolveTaskMaths> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(),
        bubblePosition: BackgroundBubblePosition.centerRight,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.alarm_add_outlined,
                      color: ThemeColors.darkBackground),
                  SizedBox(width: 5),
                  Text('0:03',
                      style: TextStyles.smallBold
                          .copyWith(fontSize: 18)
                          .copyWith(color: ThemeColors.darkBackground)),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text('7/5',
                      style: TextStyles.smallBold.copyWith(fontSize: 20)),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(width: 6),
                  Text('0 points',
                      style: TextStyles.smallBold.copyWith(fontSize: 20)),
                ],
              ),
              SizedBox(height: 5),
              Divider(color: ThemeColors.primary, thickness: 8),
              SizedBox(height: 60),
              Text('Answer this question',
                  style: TextStyles.bold.copyWith(fontSize: 18)),
              SizedBox(height: 20),
              Text('2 x 5', style: TextStyles.smallBold.copyWith(fontSize: 80)),
              SizedBox(height: 80),
              Row(
                children: [
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.backspace,
                      size: 40,
                      color: ThemeColors.lightElement,
                    ),
                    padding: EdgeInsets.only(right: 5),
                    color: Colors.red,
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    color: Colors.grey[200],
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Container(
                    child: Text('Enter',
                        style: TextStyles.bold.copyWith(
                            color: ThemeColors.lightElement, fontSize: 18)),
                    color: ThemeColors.primary,
                    margin: EdgeInsets.fromLTRB(5, 2, 0, 10),
                    height: 60,
                    width: 85,
                    alignment: Alignment.center,
                  )
                ],
              ),
            ])));
  }
}
