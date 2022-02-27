import 'package:flutter/material.dart';
import 'package:grounded/components/achieved_badge.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/device_utils.dart';

class AchievementsList extends StatelessWidget {
  final List<Achievement> achievements;
  AchievementsList({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: achievements.isEmpty
          ? Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                  "No achievements yet!. Assign some assignments to your children and they will receive achievements when they complete some assignments"),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: achievements.length,
              itemBuilder: (_, index) {
                return _buildEachAchievement(achievements[index], context);
              }),
    );
  }

  Widget _buildEachAchievement(Achievement achievement, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ThemeColors.lightElement.withOpacity(0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              AchievedBadge(
                  badge: achievement.badge, size: 40, showTitle: false),
              SizedBox(width: 15),
              SizedBox(
                width: getDeviceWidth(context) - 120,
                child: Text(
                  achievement.title,
                  style: TextStyles.regular.copyWith(fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
