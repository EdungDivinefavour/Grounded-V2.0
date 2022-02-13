import 'package:grounded/components/drawer/navigation_drawer.dart';
import 'package:grounded/components/svg_icon.dart';
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
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
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
      drawer: NavigationDrawer(groundedUser: widget.groundedUser),
      body: IndexedStack(index: _currentIndex, children: _buildTabs),
      bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyles.tiny,
          selectedLabelStyle: TextStyles.medium,
          fixedColor: ThemeColors.primary,
          onTap: _onTabTapped,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: _buildTabItems),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> get _buildTabs {
    return widget.groundedUser.userType == UserType.parent
        ? [
            HomeParent(),
            BadgesParent(parent: widget.groundedUser as Parent),
            Reports(parent: widget.groundedUser as Parent),
            Settings(),
          ]
        : [
            HomeChild(),
            BadgesChild(child: widget.groundedUser as Child),
          ];
  }

  List<BottomNavigationBarItem> get _buildTabItems {
    return widget.groundedUser.userType == UserType.parent
        ? [
            _buildEachBottomBarItem(icon: AppIcons.home),
            _buildEachBottomBarItem(icon: AppIcons.badges),
            _buildEachBottomBarItem(icon: AppIcons.reports),
            _buildEachBottomBarItem(icon: AppIcons.settings),
          ]
        : [
            _buildEachBottomBarItem(icon: AppIcons.home),
            _buildEachBottomBarItem(icon: AppIcons.badges),
          ];
  }

  BottomNavigationBarItem _buildEachBottomBarItem({required String icon}) {
    return BottomNavigationBarItem(
        icon: SVGIcon(icon: icon, color: ThemeColors.darkElement, size: 35),
        label: '');
  }
}
