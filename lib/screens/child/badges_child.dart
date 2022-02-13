import 'package:flutter/material.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/models/badge.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';

class BadgesChild extends StatelessWidget {
  final Child child;
  const BadgesChild({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(),
    );
  }

// TODO: Call this widget when you need the list of achievements
  Widget _buildAchievementsList() {
    final achievements = child.achievements;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: achievements.length,
        itemBuilder: (_, index) {
          return _buildEachAchievement(achievements[index]);
        });
  }

  // TODO: Beautify achievement here
  Widget _buildEachAchievement(Achievement achievement) {
    return Container();
  }
}
