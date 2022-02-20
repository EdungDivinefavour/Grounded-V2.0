import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/screens/parent/intro.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class Splash extends StatefulWidget {
  final User? firebaseUser;
  const Splash({this.firebaseUser});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _firestoreService = FirestoreService.instance;

  @override
  void initState() {
    super.initState();

    _getUserInfo();
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

  void _getUserInfo() async {
    if (widget.firebaseUser == null) {
      await Future.delayed(Duration(milliseconds: 3800));
      _openScreen(Intro());
      return;
    }

    GroundedUser userInfo;
    if (!widget.firebaseUser!.email!.contains("fromparent")) {
      userInfo =
          await _firestoreService.getParentInfo(widget.firebaseUser!.uid);
    } else {
      userInfo = await _firestoreService.getChildInfo(widget.firebaseUser!.uid);
    }

    await Future.delayed(Duration(milliseconds: 1800));
    _openScreen(BottomTabs(groundedUser: userInfo));
  }

  void _openScreen(Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => screen), (_) => false);
  }
}
