import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

enum InputFieldType { name, email, password, phone, number }

class InputField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool enabled;
  final InputFieldType? inputFieldType;
  final String hintText;
  final VoidCallback? onTap;
  final String? leftIcon;
  final List<String>? dropDownList;
  final Color? iconColor;
  final bool? shouldUsePNG;
  final bool? hasBorder;
  final bool? shouldRemoveTitle;
  final VoidCallback? onCancelIconTap;

  const InputField({
    required this.title,
    required this.controller,
    required this.hintText,
    this.enabled = true,
    this.inputFieldType = InputFieldType.name,
    this.onTap,
    this.leftIcon,
    this.dropDownList,
    this.iconColor,
    this.shouldUsePNG,
    this.hasBorder,
    this.shouldRemoveTitle,
    this.onCancelIconTap,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          widget.shouldRemoveTitle == null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: TextStyles.semiBold.copyWith(
                        color: ThemeColors.darkBackground, fontSize: 15),
                  ),
                )
              : emptyWidget,
          widget.shouldRemoveTitle == null ? SizedBox(height: 10) : emptyWidget,
          Stack(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: widget.hasBorder == null
                      ? null
                      : Border.all(
                          color: ThemeColors.primaryDark.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(10.0),
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
                          color: ThemeColors.darkBackground, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: widget.leftIcon == null ? 15 : 50),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: TextStyles.regular.copyWith(
                            color: ThemeColors.darkBackground, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              _buildLeftIcon,
              _buildRightIcon
            ],
          ),
        ],
      ),
    );
  }

  Widget get _buildLeftIcon {
    return widget.leftIcon == null
        ? emptyWidget
        : Container(
            height: 40,
            width: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, top: 10),
            child: widget.shouldUsePNG == null
                ? SVGIcon(
                    icon: widget.leftIcon!,
                    color: widget.iconColor ?? ThemeColors.darkBackground,
                    size: 50)
                : PNGIcon(icon: widget.leftIcon!, size: 50),
          );
  }

  Widget get _buildRightIcon {
    return widget.controller.text.isEmpty || widget.onCancelIconTap == null
        ? emptyWidget
        : Positioned(
            right: 0,
            child: InkWell(
              onTap: widget.onCancelIconTap,
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Icon(Icons.cancel),
              ),
            ),
          );
  }

  TextInputType get _buildTextInputType {
    if (widget.inputFieldType == InputFieldType.email) {
      return TextInputType.emailAddress;
    } else if (widget.inputFieldType == InputFieldType.name) {
      return TextInputType.text;
    } else if (widget.inputFieldType == InputFieldType.password) {
      return TextInputType.text;
    }

    return TextInputType.text;
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
