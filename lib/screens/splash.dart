import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/screens/bottom_tabs.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';

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
    return CustomScaffold(body: Container());
  }

  void _openNextScreen() {
    final nextScreen = widget.groundedUser == null
        ? LoginParent()
        : BottomTabs(groundedUser: widget.groundedUser!);

    Future.delayed(const Duration(milliseconds: 3800), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => nextScreen), (_) => false);
    });
  }
}
