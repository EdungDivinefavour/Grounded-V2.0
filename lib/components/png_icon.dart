import 'package:flutter/material.dart';
import 'package:grounded/constants/strings/paths.dart';

enum PNGSource { icons, images }

class PNGIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  final PNGSource? pngSource;

  const PNGIcon({
    required this.icon,
    this.pngSource = PNGSource.icons,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '${pngSource == PNGSource.icons ? iconPath : imagePath}$icon',
      height: size,
      width: size,
      color: color,
    );
  }
}
