import 'package:flutter/material.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class MultiplicationChoice extends StatefulWidget {
  final String title;
  final void Function(void Function()) stateSetter;
  final bool isSelected;
  final VoidCallback onTap;

  MultiplicationChoice({
    required this.title,
    required this.stateSetter,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<MultiplicationChoice> createState() => _MultiplicationChoiceState();
}

class _MultiplicationChoiceState extends State<MultiplicationChoice> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.stateSetter.call(() {
          widget.onTap.call();
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: ThemeColors.lightElement,
              border: Border.all(
                  color: widget.isSelected
                      ? ThemeColors.primaryDark
                      : ThemeColors.primary,
                  width: 5)),
          alignment: Alignment.center,
          child: Text(widget.title,
              style: TextStyles.semiBold
                  .copyWith(fontSize: 17, color: ThemeColors.primary))),
    );
  }
}
