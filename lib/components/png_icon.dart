import 'package:flutter/material.dart';
import 'package:grounded/constants/strings/paths.dart';

class PNGIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;

  const PNGIcon({required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath + icon,
      height: size,
      width: size,
      color: color,
    );
  }
}
