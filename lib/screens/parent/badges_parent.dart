import 'package:flutter/material.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/models/badge.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class BadgesParent extends StatelessWidget {
  final Parent parent;
  const BadgesParent({required this.parent});

  List<Achievement> get _achievements => _setupAchievementLists;
  List<Badge> get _badges => _achievements.map((e) => e.badge).toList();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Icon(Icons.list_outlined),
                  Spacer(),
                  Icon(Icons.notifications)
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Insights!",
                  style: TextStyles.extraBold.copyWith(fontSize: 24),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Below are the achievements and badges of your kids this week",
                  style: TextStyles.regular,
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Badges",
                  style: TextStyles.extraBold.copyWith(fontSize: 20),
                ),
              ),
              _buildBadgeList(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Achievements",
                  style: TextStyles.extraBold.copyWith(fontSize: 20),
                ),
              ),
              _buildAchievementsList()
            ])));
  }

// TODO: Call this widget when you need the list of badges
  Widget _buildBadgeList() {
    return SizedBox(
        height: 110,
        child: _badges.isEmpty
            ? Text("No badges received yet!. Do some assignments to get badges")
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemCount: _badges.length,
                itemBuilder: (_, index) {
                  return _buildEachBadge(_badges[0]);
                },
              ));
  }

// TODO: Call this widget when you need the list of achievements
  Widget _buildAchievementsList() {
    return SizedBox(
      child: _badges.isEmpty
          ? Text("No achievements yet!. Complete some assignments")
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _achievements.length,
              itemBuilder: (_, index) {
                return _buildEachAchievement(_achievements[index]);
              }),
    );
  }

  // TODO: Beautify badge here
  Widget _buildEachBadge(Badge badge) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
          ),
          Text('Champion')
        ],
      ),
    );
  }

  // TODO: Beautify achievement here
  Widget _buildEachAchievement(Achievement achievement) {
    return Container();
  }

  List<Achievement> get _setupAchievementLists {
    final List<Achievement> achievements = [];
    for (final e in parent.children) {
      achievements.addAll(e.achievements);
    }

    return achievements;
  }
}
