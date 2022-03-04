import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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
                              child: SVGIcon(
                                icon: leftIcon,
                                color: ThemeColors.darkElement.withOpacity(0.8),
                                size: 27.5,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(title,
                                    style: TextStyles.semiBold
                                        .copyWith(fontSize: 17)))
                          ],
                        ))
                  ],
                ))));
  }

  void _launchScreen(BuildContext context, String title) {
    Navigator.pop(context);

    if (title == "Log Out") {
      _authService.signOutUser();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => screenToLaunch!),
        (_) => false,
      );
    } else if (title == "Share") {
      Share.share(
          "Grounded is the awesome app i use to get the assign tasks to my kids from the comfort of my office or anywhere i'm at with just a few clicks. \n\nYou can download Grounded from the store using the following link https://apps.apple.com/ca/app/grounded/id1563059291",
          subject: "Grounded");
    } else if (title == "Contact") {
      _openContactOptionSheet(context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => screenToLaunch!));
    }
  }

  void _openContactOptionSheet(BuildContext context) async {
    final result = await showModalActionSheet<String>(
        context: context,
        title: "Select option",
        actions: [
          SheetAction(key: "call_support", label: "Call Support"),
          SheetAction(key: "email_support", label: "Email Support"),
        ]);

    if (result == "call_support") {
      launch("tel: +2348168964795");
    } else if (result == "email_support") {
      final ticketNumber = (Random().nextInt(91039) + 29332);
      final emailLaunchUri = Uri(
          scheme: 'mailto',
          path: "mleechin@hotmail.com",
          queryParameters: {'subject': 'Ticket $ticketNumber'});
      launch(emailLaunchUri.toString());
    }
  }
}
