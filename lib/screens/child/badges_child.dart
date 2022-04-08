import 'package:flutter/material.dart';
import 'package:grounded/components/achieved_badge.dart';
import 'package:grounded/components/achievements_list.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class BadgesChild extends StatefulWidget {
  final Child child;
  const BadgesChild({required this.child});

  @override
  State<BadgesChild> createState() => _BadgesChildState();
}

class _BadgesChildState extends State<BadgesChild> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bubblePosition: BackgroundBubblePosition.topRight,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 900,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: ScreenTitle(
                  title: "You Rock!",
                  isWhiteBackround: true,
                  titleTextStyle: TextStyles.chalkboard.copyWith(fontSize: 40),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                    "Your parents will see these great \nachievements and you might just get a reward! 😉",
                    style: TextStyles.chalkboard.copyWith(fontSize: 22)),
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text('Latest Badge',
                        style: TextStyles.chalkboard.copyWith(fontSize: 30)),
                    SizedBox(height: 10),
                    AchievedBadge(
                      badge: widget.child.achievements.last.badge,
                      size: 90,
                      titleFontSize: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: ThemeColors.primaryLight,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text("Achievements",
                            style:
                                TextStyles.chalkboard.copyWith(fontSize: 22)),
                      ),
                      AchievementsList(achievements: widget.child.achievements),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
