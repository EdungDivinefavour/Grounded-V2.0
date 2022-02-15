import 'package:flutter/material.dart';
import 'package:grounded/components/achieved_badge.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
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
            ScreenTitle(title: "Badges", isWhiteBackround: true),
            Container(),
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
