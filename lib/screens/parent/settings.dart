import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/screens/parent/change_password.dart';
import 'package:grounded/screens/parent/communications.dart';
import 'package:grounded/screens/parent/notifications.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/launcher_utils.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            _buildSettingsItem(
                title: "Communications", screenToLaunch: Communications()),
            _buildSettingsItem(
                title: "Notifications", screenToLaunch: Notifications()),
            _buildSettingsItem(
                title: "Password Settings", screenToLaunch: ChangePassword()),
            SizedBox(height: 50),
            Container(
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

  Widget _buildSettingsItem({required String title, dynamic screenToLaunch}) {
    return InkWell(
        onTap: () {
          _navigateToPage(screenToLaunch);
        },
        child: SizedBox(
          height: 50,
          child: Column(
            children: [
              Spacer(),
              Row(
                children: [
                  Text(title, style: TextStyles.regular),
                  Spacer(),
                  SVGIcon(icon: AppIcons.forward, size: 15)
                ],
              ),
              Spacer(),
              Divider(height: 2, thickness: 1.5),
            ],
          ),
        ));
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
