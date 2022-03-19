import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

enum InputFieldType { name, email, password, phone, number }

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final InputFieldType? inputFieldType;
  final String hintText;
  final String title;
  final VoidCallback? onTap;
  final String? leftIcon;
  final String? rightIcon;
  final List<String>? dropDownList;
  final ValueChanged<String?>? onDropDownChange;
  final Color? iconColor;

  const InputField({
    required this.controller,
    required this.hintText,
    required this.title,
    this.enabled = true,
    this.inputFieldType = InputFieldType.name,
    this.onTap,
    this.leftIcon,
    this.rightIcon,
    this.dropDownList,
    this.onDropDownChange,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyles.semiBold
                .copyWith(color: ThemeColors.darkBackground, fontSize: 15),
          ),
        ),
        SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ThemeColors.lightBackground,
              ),
              child: InkWell(
                onTap: onTap,
                child: IgnorePointer(
                  ignoring: false,
                  child: TextField(
                    enabled: _isEnabled,
                    keyboardType: _buildTextInputType,
                    controller: controller,
                    obscureText: inputFieldType == InputFieldType.password,
                    autocorrect: false,
                    style: TextStyles.regular.copyWith(
                        color: ThemeColors.darkBackground, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: leftIcon == null ? 15 : 50),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyles.regular.copyWith(
                          color: ThemeColors.darkBackground, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
            _buildLeftIcon,
            _buildDropDownIcon
          ],
        ),
      ],
    );
  }

  Widget get _buildLeftIcon {
    return leftIcon == null
        ? emptyWidget
        : Container(
            height: 40,
            width: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, top: 10),
            child: SVGIcon(
                icon: leftIcon!,
                color: iconColor ?? ThemeColors.darkBackground,
                size: 50),
          );
  }

  Widget get _buildDropDownIcon {
    return dropDownList == null
        ? emptyWidget
        : Positioned(
            right: 0,
            child: DropdownButton(
              underline: emptyWidget,
              onChanged: onDropDownChange,
              items: dropDownList?.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              icon: Container(
                height: 30,
                width: 30,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(right: 10),
                child: SVGIcon(
                    icon: AppIcons.down,
                    color: ThemeColors.darkBackground,
                    size: 40),
              ),
            ),
          );
  }

  TextInputType get _buildTextInputType {
    if (inputFieldType == InputFieldType.email) {
      return TextInputType.emailAddress;
    } else if (inputFieldType == InputFieldType.name) {
      return TextInputType.text;
    } else if (inputFieldType == InputFieldType.password) {
      return TextInputType.text;
    }

    return TextInputType.text;
  }

  bool get _isEnabled {
    if (!enabled) {
      return false;
    } else if (onTap != null) {
      return false;
    } else if (dropDownList != null) {
      return false;
    }

    return true;
  }
}
