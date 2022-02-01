import 'package:flutter/material.dart';
import 'package:grounded/screens/parent/add_child.dart';
import 'package:grounded/screens/parent/home_parent.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';

class Splash extends StatefulWidget {
  final bool isSessionStillActive;
  const Splash({this.isSessionStillActive = false});

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
    return Scaffold(backgroundColor: ThemeColors.primary);
  }

  void _openNextScreen() {
    final nextScreen = widget.isSessionStillActive ? AddChild() : LoginParent();

    Future.delayed(const Duration(milliseconds: 3800), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => nextScreen), (_) => false);
    });
  }
}
