import 'package:flutter/material.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';

enum InputFieldType { name, email, password, phone, number }

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final bool enabled;
  final InputFieldType? inputFieldType;
  final String hintText;
  final String title;

  const InputField({
    required this.controller,
    required this.hintText,
    required this.title,
    this.enabled = true,
    this.inputFieldType = InputFieldType.name,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Text(widget.title)),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ThemeColors.lightBackground,
          ),
          child: TextField(
              enabled: widget.enabled,
              keyboardType: _buildTextInputType(),
              controller: widget.controller,
              obscureText: widget.inputFieldType == InputFieldType.password,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: widget.hintText,
                  suffixIcon: _isValidated
                      ? const Padding(
                          padding: EdgeInsetsDirectional.all(12),
                          child: SVGIcon(icon: AppIcons.checkBox),
                        )
                      : null),
              onChanged: (_) {
                setState(() {});
              }),
        ),
      ],
    );
  }

  bool get _isValidated {
    if (widget.inputFieldType == null) return true;

    if (widget.inputFieldType == InputFieldType.email) {
      return widget.controller.text.contains("@") &&
          widget.controller.text.contains(".com");
    } else if (widget.inputFieldType == InputFieldType.name) {
      return widget.controller.text.length > 3 &&
          widget.controller.text.contains(" ");
    } else if (widget.inputFieldType == InputFieldType.password) {
      return widget.controller.text.length > 6;
    }

    return false;
  }

  TextInputType _buildTextInputType() {
    if (widget.inputFieldType == InputFieldType.email) {
      return TextInputType.emailAddress;
    } else if (widget.inputFieldType == InputFieldType.name) {
      return TextInputType.name;
    } else if (widget.inputFieldType == InputFieldType.password) {
      return TextInputType.name;
    }

    return TextInputType.name;
  }
}
