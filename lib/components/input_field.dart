import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

enum InputFieldType { name, email, password, phone, number }

class InputField extends StatefulWidget {
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
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: TextStyles.semiBold.copyWith(
              color: ThemeColors.darkBackground,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: ThemeColors.lightBackground,
              ),
              child: InkWell(
                onTap: widget.onTap,
                child: IgnorePointer(
                  ignoring: false,
                  child: TextField(
                      enabled: _isEnabled,
                      keyboardType: _buildTextInputType,
                      controller: widget.controller,
                      obscureText:
                          widget.inputFieldType == InputFieldType.password,
                      autocorrect: false,
                      style: TextStyles.regular.copyWith(
                        color: ThemeColors.darkBackground,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: widget.leftIcon == null ? 10 : 45),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: TextStyles.regular.copyWith(
                          color: ThemeColors.darkBackground,
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {});
                      }),
                ),
              ),
            ),
            _buildLeftIcon,
            // _buildRightIcon
            _buildDropDownIcon
          ],
        ),
      ],
    );
  }

  Widget get _buildLeftIcon {
    return widget.leftIcon == null
        ? emptyWidget
        : Container(
            height: 60,
            width: 60,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, top: 10),
            child: SVGIcon(
                icon: widget.leftIcon!,
                color: ThemeColors.darkBackground,
                size: 50),
          );
  }

  Widget get _buildRightIcon {
    return widget.rightIcon == null
        ? emptyWidget
        : SizedBox(
            height: 60,
            width: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: SVGIcon(
                  icon: widget.rightIcon!,
                  color: ThemeColors.darkBackground,
                  size: 50),
            ),
          );
  }

  Widget get _buildDropDownIcon {
    return widget.dropDownList == null
        ? emptyWidget
        : Positioned(
            right: 0,
            child: DropdownButton(
              underline: emptyWidget,
              onChanged: widget.onDropDownChange,
              items: widget.dropDownList?.map((e) {
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
    if (widget.inputFieldType == InputFieldType.email) {
      return TextInputType.emailAddress;
    } else if (widget.inputFieldType == InputFieldType.name) {
      return TextInputType.name;
    } else if (widget.inputFieldType == InputFieldType.password) {
      return TextInputType.name;
    }

    return TextInputType.name;
  }

  bool get _isEnabled {
    if (!widget.enabled) {
      return false;
    } else if (widget.onTap != null) {
      return false;
    } else if (widget.dropDownList != null) {
      return false;
    }

    return true;
  }
}
