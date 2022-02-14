import 'package:flutter/material.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CustomCheckBox extends StatefulWidget {
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;

  CustomCheckBox({required this.title, required this.value, this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return CustomCheckBoxState();
  }
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                    value: widget.value,
                    checkColor: Colors.white, // color of tick Mark
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: widget.onChanged)),
            SizedBox(width: 10.0),
            Text(widget.title, style: TextStyles.regular),
          ]),
    );
  }
}
