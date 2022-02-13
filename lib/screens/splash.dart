import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/screens/intro.dart';
import 'package:grounded/screens/parent/add_task.dart';
import 'package:grounded/screens/parent/forgot_password.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/screens/parent/register_parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class Splash extends StatefulWidget {
  final GroundedUser? groundedUser;
  const Splash({this.groundedUser});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    _openNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundColor: ThemeColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PNGIcon(size: 100, icon: AppIcons.logoPNG),
              SizedBox(height: 20),
              Text(
                'Grounded',
                style: TextStyles.extraBold
                    .copyWith(color: ThemeColors.lightElement, fontSize: 26),
              )
            ],
          ),
        ));
  }

  void _openNextScreen() {
    final nextScreen = widget.groundedUser == null
        ? Intro()
        : BottomTabs(groundedUser: widget.groundedUser!); //

    Future.delayed(const Duration(milliseconds: 3800), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => nextScreen), (_) => false);
    });
  }
}
