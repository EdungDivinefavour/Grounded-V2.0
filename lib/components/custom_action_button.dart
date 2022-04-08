import 'package:flutter/material.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CustomActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  final bool isWhite;
  final bool isRedButton;
  final bool hasChalkBoardFont;

  const CustomActionButton({
    required this.onPressed,
    required this.title,
    this.enabled = true,
    this.isWhite = false,
    this.isRedButton = true,
    this.hasChalkBoardFont = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isRedButton ? ThemeColors.error : ThemeColors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        height: 50,
        alignment: Alignment.center,
        child: Text(title,
            style: (hasChalkBoardFont
                    ? TextStyles.chalkboard.copyWith(fontSize: 24)
                    : TextStyles.bold)
                .copyWith(
              color: isWhite ? ThemeColors.primary : ThemeColors.lightElement,
            )),
      ),
    );
  }
}
