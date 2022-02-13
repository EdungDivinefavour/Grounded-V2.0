import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grounded/constants/strings/paths.dart';

class SVGIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;

  const SVGIcon({required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath + icon,
      height: size,
      width: size,
      color: color,
    );
  }
}
