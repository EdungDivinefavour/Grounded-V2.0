import 'package:flutter/material.dart';
import 'package:grounded/screens/parent/change_password.dart';
import 'package:grounded/screens/parent/communications.dart';
import 'package:grounded/screens/parent/notifications.dart';
import 'package:grounded/utils/launcher_utils.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSettingsItem(
              title: "Communications", screenToLaunch: Communications()),
          _buildSettingsItem(
              title: "Notifications", screenToLaunch: Notifications()),
          Text("Legal"),
          SizedBox(height: 60),
          _buildSettingsItem(
              title: "Password Settings", screenToLaunch: ChangePassword()),
          _buildSettingsItem(
              title: "Privacy Policy", screenToLaunch: "privacyPolicy"),
          _buildSettingsItem(
              title: "Terms Of Service", screenToLaunch: "termsOfService"),
        ],
      ),
    );
  }

// TODO: Build the settings item here
  Widget _buildSettingsItem({required String title, dynamic screenToLaunch}) {
    return InkWell(
      onTap: () => _navigateToPage(screenToLaunch),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(25),
        color: Colors.green,
        width: 100,
        height: 50,
        child: Text(title),
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
