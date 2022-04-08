import 'package:flutter/material.dart';
import 'package:grounded/styles/texts/text_styles.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get toChalkBoard {
    return copyWith(fontFamily: chalkBoardFamily);
  }
}
