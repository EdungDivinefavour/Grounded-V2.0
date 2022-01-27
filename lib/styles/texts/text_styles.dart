import 'package:flutter/material.dart';

const regularFamily = '"Montserrat-Regular"';
const boldFamily = 'Montserrat-Bold';

class TextStyles {
  static const tiny = TextStyle(fontSize: 12, fontFamily: regularFamily);
  static const small = TextStyle(fontSize: 14, fontFamily: regularFamily);
  static const regular = TextStyle(fontSize: 16, fontFamily: regularFamily);
  static const medium = TextStyle(fontSize: 17, fontFamily: boldFamily);
  static const bold = TextStyle(fontSize: 18, fontFamily: boldFamily);
  static const extraBold = TextStyle(fontSize: 20, fontFamily: boldFamily);
}
