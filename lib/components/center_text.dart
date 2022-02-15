import 'package:flutter/material.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CenterText extends StatelessWidget {
  final String text;
  CenterText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, style: TextStyles.regular));
  }
}
