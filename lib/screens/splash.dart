import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final String? displayName;
  const Splash({this.displayName});

  @override
  Widget build(BuildContext context) {
    return displayName == null ? Container() : Container();
  }
}
