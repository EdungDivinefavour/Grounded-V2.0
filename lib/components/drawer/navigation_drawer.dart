import 'package:grounded/components/drawer/drawer_header_item.dart';
import 'package:grounded/components/drawer/drawer_list_item.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/styles/icons/app_icons.dart';
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
          child: ListView(
            children: [
              DrawerHeaderItem(
                title: "Hey, " + shortenToFirstOnly(groundedUser.name),
                profilePhoto: AppIcons.profile,
              ),
              ..._buildDrawerItemsList
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
      // DrawerListItem(
      //   title: "About",
      //   leftIcon: AppIcons.info,
      //   screenToLaunch: About(),
      // ),
      // DrawerListItem(
      //   title: "Contact",
      //   leftIcon: AppIcons.contact,
      //   screenToLaunch: About(),
      // ),
      // DrawerListItem(
      //   title: "Logout",
      //   leftIcon: AppIcons.logout,
      //   screenToLaunch: About(),
      // ),
    ];
  }
}
