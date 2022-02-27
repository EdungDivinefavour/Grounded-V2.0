import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/models/badge.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AchievedBadge extends StatelessWidget {
  final Badge badge;
  final bool showTitle;
  final double? size;
  final double? titleFontSize;

  AchievedBadge({
    required this.badge,
    this.size = 65,
    this.titleFontSize = 13,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PNGIcon(icon: badge.image, pngSource: PNGSource.images, size: size),
        showTitle ? SizedBox(height: 7.5) : emptyWidget,
        showTitle
            ? Text(badge.name,
                style: TextStyles.smallBold.copyWith(fontSize: titleFontSize))
            : emptyWidget
      ],
    );
  }
}
