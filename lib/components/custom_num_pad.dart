import 'package:flutter/material.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CustomNumPad extends StatefulWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback? onEnter;
  final VoidCallback? onDelete;

  const CustomNumPad({
    required this.onKeyPressed,
    this.onEnter,
    this.onDelete,
  });

  @override
  State<CustomNumPad> createState() => _CustomNumPadState();
}

class _CustomNumPadState extends State<CustomNumPad> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          _buildNumRows(["1", "2", "3"]),
          _buildNumRows(["4", "5", "6"]),
          _buildNumRows(["7", "8", "9"]),
          _buildNumRows(["delete", "0", "Enter"]),
        ],
      ),
    );
  }

  Widget _buildNumRows(List<String> buttonTexts) {
    return Row(
      children: buttonTexts.map((x) {
        return _buildNumButton(x);
      }).toList(),
    );
  }

  Widget _buildNumButton(String buttonText) {
    return InkWell(
      onTap: () {
        _handleNumPressed(buttonText);
      },
      child: Container(
        margin: EdgeInsets.all(7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: buttonText == "Enter"
              ? ThemeColors.primary
              : buttonText == "Delete"
                  ? ThemeColors.error
                  : ThemeColors.lightBackground,
        ),
        height: MediaQuery.of(context).size.height / 14.75,
        width: MediaQuery.of(context).size.width / 3.85,
        alignment: Alignment.center,
        child: buttonText == "Delete"
            ? SVGIcon(icon: AppIcons.backSpace, size: 35)
            : Text(buttonText,
                style: TextStyles.semiBold.copyWith(
                    fontSize: 22,
                    color: buttonText == "Enter"
                        ? ThemeColors.lightElement
                        : ThemeColors.darkElement)),
      ),
    );
  }

  void _handleNumPressed(String buttonText) {
    if (buttonText == "Delete") {
      widget.onDelete?.call();
      return;
    } else if (buttonText == "Enter") {
      widget.onEnter?.call();
      return;
    }

    return widget.onKeyPressed.call(buttonText);
  }
}
