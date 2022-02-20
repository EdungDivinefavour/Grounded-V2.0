import 'package:flutter/material.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class SolveTaskEnglish extends StatefulWidget {
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
        child: Column(
          children: [
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
                Text('10/10',
                    style: TextStyles.smallBold.copyWith(fontSize: 20)),
                Spacer(),
                Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                SizedBox(width: 6),
                Text('100 points',
                    style: TextStyles.smallBold.copyWith(fontSize: 20)),
              ],
            ),
            SizedBox(height: 5),
            Divider(color: ThemeColors.primary, thickness: 8),
            SizedBox(height: 60),
            Text('What letter is missing?',
                style: TextStyles.bold.copyWith(fontSize: 18)),
            SizedBox(height: 40),
            PNGIcon(size: 160, icon: AppIcons.trumpetPNG),
            SizedBox(height: 60),
            Text('TRU_PET', style: TextStyles.medium.copyWith(fontSize: 60)),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 0, 2),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 0, 2),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 0, 2),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.fromLTRB(2, 2, 0, 2),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomActionButton(onPressed: () {}, title: 'Proceed'),
          ],
        ),
      ),
    );
  }
}
