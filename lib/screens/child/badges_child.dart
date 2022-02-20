import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:grounded/components/achieved_badge.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';

class BadgesChild extends StatefulWidget {
  final Child child;
  const BadgesChild({required this.child});

  @override
  State<BadgesChild> createState() => _BadgesChildState();
}

class _BadgesChildState extends State<BadgesChild> {
  List<Achievement> _achievements = [];

  @override
  void initState() {
    super.initState();

    _getAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(hasDrawer: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ScreenTitle(
              title: "You Rock!",
              isWhiteBackround: true,
              subTitle:
                  "Your parents will see these great \nachievements and you might just get a reward!",
            ),
            SizedBox(height: 60),
            Container(
                child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Latest Badge', style: TextStyles.extraBold),
                  SizedBox(height: 10),
                  Icon(
                    Icons.notifications_active_sharp,
                    size: 80,
                    color: Colors.purple,
                  ),
                  SizedBox(height: 5),
                  Text('Champion', style: TextStyles.smallBold)
                ],
              ),
            )),
            SizedBox(height: 35),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Achievements",
                style: TextStyles.bold.copyWith(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.ac_unit_rounded,
                      size: 40, color: Colors.orangeAccent),
                ),
                Text('You completed 10 maths \nassignments in a row',
                    style: TextStyles.smallRegular)
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.ac_unit_rounded,
                      size: 40, color: Colors.orangeAccent),
                ),
                Text('Yesterday you accomplished 10 \nenglish assignments',
                    style: TextStyles.smallRegular)
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.ac_unit_rounded,
                      size: 40, color: Colors.orangeAccent),
                ),
                Text('Completed 10 maths assignments \nin a row',
                    style: TextStyles.smallRegular)
              ],
            )
          ],
        ),
      ),
    );
  }

// TODO: Call this widget when you need the list of achievements
  Widget _buildAchievementsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _achievements.length,
        itemBuilder: (_, index) {
          return _buildEachAchievement(_achievements[index]);
        });
  }

  // TODO: Beautify achievement here
  Widget _buildEachAchievement(Achievement achievement) {
    return Container();
  }

  Widget _buildLatestBadge() {
    return AchievedBadge(badge: _achievements.first.badge);
  }

  void _getAchievements() {
    _achievements = widget.child.achievements.reversed.toList();
  }
}
