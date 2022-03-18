import 'package:grounded/components/drawer/drawer_header_item.dart';
import 'package:grounded/components/drawer/drawer_list_item.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/about.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/screens/parent/assigned_tasks.dart';
import 'package:grounded/screens/parent/intro.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/string_utils.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final GroundedUser groundedUser;
  const NavigationDrawer({required this.groundedUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 280,
        child: Drawer(
          backgroundColor: ThemeColors.primary,
          child: Column(
            children: [
              SizedBox(height: 50),
              DrawerHeaderItem(
                title: "Hey, " + shortenToFirstOnly(groundedUser.name),
                profilePhoto: groundedUser.profilePhoto,
              ),
              ..._buildDrawerItemsList,
              Spacer(),
              PNGIcon(size: 70, icon: AppIcons.logoPNG, radius: 15),
              SizedBox(height: 20),
              Text("Grounded V2.0.0",
                  style: TextStyles.bold
                      .copyWith(fontSize: 15, color: ThemeColors.lightElement)),
              SizedBox(height: 50)
            ],
          ),
        ));
  }

  List<Widget> get _buildDrawerItemsList {
    return [
      DrawerListItem(
        title: "Home",
        leftIcon: AppIcons.home,
        screenToLaunch: BottomTabs(groundedUser: groundedUser),
      ),
      DrawerListItem(
        title: "Assigned Tasks",
        leftIcon: AppIcons.tasks,
        screenToLaunch: AssignedTask(),
      ),
      DrawerListItem(
        title: "About",
        leftIcon: AppIcons.info,
        screenToLaunch: About(),
      ),
      DrawerListItem(
        title: "Share",
        leftIcon: AppIcons.share,
      ),
      DrawerListItem(
        title: "Contact",
        leftIcon: AppIcons.support,
      ),
      DrawerListItem(
        title: "Log Out",
        leftIcon: AppIcons.logout,
        screenToLaunch: Intro(),
      ),
    ];
  }
}
