import 'package:flutter/material.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool isWhiteForeground;
  final bool isWhiteBackround;

  ScreenTitle({
    required this.title,
    this.subTitle,
    this.isWhiteForeground = false,
    this.isWhiteBackround = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      color: isWhiteBackround ? ThemeColors.lightElement : ThemeColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.extraBold.copyWith(
              fontSize: 25,
              color: isWhiteForeground
                  ? ThemeColors.lightElement
                  : ThemeColors.darkElement,
            ),
          ),
          subTitle == null
              ? SizedBox(height: 20)
              : Text(subTitle!, style: TextStyles.regular)
        ],
      ),
    );
  }
}
