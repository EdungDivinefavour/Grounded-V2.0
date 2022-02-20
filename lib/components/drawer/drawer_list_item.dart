import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final String title;
  final String leftIcon;
  final Widget? screenToLaunch;
  final String? adminEmail;
  final String? adminPhoneNumber;

  final _authService = AuthenticationService.instance;

  DrawerListItem({
    required this.title,
    required this.leftIcon,
    this.screenToLaunch,
    this.adminEmail,
    this.adminPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: InkWell(
            onTap: () => _launchScreen(context, title),
            child: SizedBox(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: SVGIcon(
                                icon: leftIcon,
                                color: ThemeColors.darkElement.withOpacity(0.8),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(title, style: TextStyles.semiBold))
                          ],
                        ))
                  ],
                ))));
  }

  void _launchScreen(BuildContext context, String title) {
    Navigator.pop(context);

    if (title == "Contact Us") {
    } else if (title == "Log Out") {
      _authService.signOutUser();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => screenToLaunch!),
        (_) => false,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => screenToLaunch!));
    }
  }
}
