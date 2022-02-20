import 'package:flutter/material.dart';

class ThemeColors {
  static const primary = Color.fromRGBO(52, 108, 220, 1);
  // static const primary = Color.fromRGBO(25, 196, 140, 1);
  static get primaryLight => primary.withOpacity(0.1);
  static const accent = Color.fromRGBO(232, 176, 0, 1);
  static const transparent = Colors.transparent;
  static const success = Color.fromRGBO(25, 170, 90, 1);
  static const error = Color.fromRGBO(252, 61, 34, 1);
  static const link = Colors.orange;
  static const lightBackground = Color.fromRGBO(245, 245, 245, 1);
  static const darkBackground = Color.fromRGBO(122, 134, 154, 1);
  static const darkElement = Colors.black;
  static const lightElement = Colors.white;
}
