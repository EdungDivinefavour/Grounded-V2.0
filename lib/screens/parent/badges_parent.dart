import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/achieved_badge.dart';
import 'package:grounded/components/achievements_list.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/achievement.dart';
import 'package:grounded/models/badge.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class BadgesParent extends StatefulWidget {
  final Parent parent;
  const BadgesParent({required this.parent});

  @override
  State<BadgesParent> createState() => _BadgesParentState();
}

class _BadgesParentState extends State<BadgesParent> {
  final _firestoreService = FirestoreService.instance;
  final _children = <Child>[];

  List<Achievement> get _achievements => _setupAchievementLists;
  List<Badge?> get _badges => _achievements.map((e) => e.badge).toList();

  @override
  void initState() {
    super.initState();

    _getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: 900,
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ScreenTitle(title: "Badges", isWhiteBackround: true),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Below are the achievements and badges of your kids this week",
                    style: TextStyles.regular,
                  ),
                ),
                SizedBox(height: 30),
                _buildBadgeList(),
              ],
            ),
          ),
          SizedBox(height: 30),
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
                        style: TextStyles.extraBold.copyWith(fontSize: 20)),
                  ),
                  AchievementsList(achievements: _achievements),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }

  Widget _buildBadgeList() {
    return SizedBox(
        height: 100,
        child: _achievements.isEmpty
            ? Text(
                "No badges received yet!. Assign some assignments to your child(ren) and they will receive badges upon completion")
            : ListView.separated(
                separatorBuilder: (_, __) {
                  return SizedBox(width: 40);
                },
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemCount: _badges.length,
                itemBuilder: (_, index) {
                  final badge = _badges[index];

                  return badge == null
                      ? emptyWidget
                      : AchievedBadge(badge: badge);
                },
              ));
  }

  List<Achievement> get _setupAchievementLists {
    final List<Achievement> achievements = [];
    for (final x in _children) {
      achievements.addAll(x.achievements);
    }

    return achievements;
  }

  void _getChildren() async {
    EasyLoading.show();
    final result = await _firestoreService.getChildrenForParent(widget.parent);

    EasyLoading.dismiss();
    setState(() {
      _children.addAll(result);
    });
  }
}
