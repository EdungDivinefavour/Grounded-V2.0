import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_bottom_bar.dart';
import 'package:grounded/components/drawer/navigation_drawer.dart';
import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/child/badges_child.dart';
import 'package:grounded/screens/child/home_child.dart';
import 'package:grounded/screens/parent/badges_parent.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/screens/parent/reports.dart';
import 'package:grounded/screens/parent/settings.dart';
import 'package:grounded/screens/parent/view_notifications.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';

class BottomTabs extends StatefulWidget {
  final GroundedUser groundedUser;

  const BottomTabs({required this.groundedUser});
  @override
  State<StatefulWidget> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        hasDrawer: true,
        onRightIconTap: _openViewNotificationsScreen,
      ),
      drawer: NavigationDrawer(groundedUser: widget.groundedUser),
      body: IndexedStack(index: _currentIndex, children: _buildTabs),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        iconSize: 30,
        items: _buildTabItems,
      ),
    );
  }

  List<Widget> get _buildTabs {
    return widget.groundedUser.userType == UserType.parent
        ? [
            HomeParent(parent: widget.groundedUser as Parent),
            BadgesParent(parent: widget.groundedUser as Parent),
            Reports(parent: widget.groundedUser as Parent),
            Settings(),
          ]
        : [
            HomeChild(child: widget.groundedUser as Child),
            BadgesChild(child: widget.groundedUser as Child),
          ];
  }

  List<CustomBottomBarItem> get _buildTabItems {
    return widget.groundedUser.userType == UserType.parent
        ? [
            _buildEachBottomBarItem(title: "Home", icon: AppIcons.home),
            _buildEachBottomBarItem(title: "Badges", icon: AppIcons.badges),
            _buildEachBottomBarItem(title: "Reports", icon: AppIcons.reports),
            _buildEachBottomBarItem(title: "Settings", icon: AppIcons.settings),
          ]
        : [
            _buildEachBottomBarItem(title: "Home", icon: AppIcons.home),
            _buildEachBottomBarItem(title: "Badges", icon: AppIcons.badges),
          ];
  }

  CustomBottomBarItem _buildEachBottomBarItem({
    required String title,
    required String icon,
  }) {
    return CustomBottomBarItem(
      icon: icon,
      title: title,
      selectedColor: ThemeColors.primary,
    );
  }

  void _openViewNotificationsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ViewNotifications()));
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
