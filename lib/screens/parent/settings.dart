import 'package:flutter/material.dart';
import 'package:grounded/screens/parent/change_password.dart';
import 'package:grounded/screens/parent/communications.dart';
import 'package:grounded/screens/parent/notifications.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/launcher_utils.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.list_outlined),
                Spacer(),
                Icon(Icons.notifications)
              ],
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: TextStyles.extraBold.copyWith(fontSize: 25),
              ),
            ),
            _buildSettingsItem(
                title: "Communications", screenToLaunch: Communications()),
            _buildSettingsItem(
                title: "Notifications", screenToLaunch: Notifications()),
            _buildSettingsItem(
                title: "Password Settings", screenToLaunch: ChangePassword()),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Legal",
                style: TextStyles.extraBold.copyWith(fontSize: 22),
              ),
            ),
            SizedBox(height: 10),
            _buildSettingsItem(
                title: "Privacy Policy", screenToLaunch: "privacyPolicy"),
            _buildSettingsItem(
                title: "Terms Of Service", screenToLaunch: "termsOfService"),
          ],
        ),
      ),
    );
  }

// TODO: Build the settings item here
  Widget _buildSettingsItem({required String title, dynamic screenToLaunch}) {
    return InkWell(
      onTap: () {
        _navigateToPage(screenToLaunch);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(title, style: TextStyles.regular),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                  color: ThemeColors.darkBackground,
                ),
              ],
            ),
            Divider(height: 2, thickness: 1.5),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(dynamic whatToLaunch) async {
    if (whatToLaunch == "privacyPolicy" || whatToLaunch == "termsOfService") {
      final url = whatToLaunch == "privacyPolicy"
          ? "https://grounded.com/privacy-policy"
          : "https://grounded.com/terms-of-service";

      launchUri(url: url);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => whatToLaunch));
  }
}
