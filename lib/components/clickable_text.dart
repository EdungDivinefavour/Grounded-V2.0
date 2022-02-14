import 'package:flutter/material.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ClickableText(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyles.small.copyWith(color: ThemeColors.link),
      ),
      onPressed: onPressed,
    );
  }
}
