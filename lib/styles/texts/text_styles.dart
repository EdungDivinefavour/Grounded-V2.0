import 'package:flutter/material.dart';

const lightFamily = 'Poppins-Light';
const regularFamily = 'Poppins-Regular';
const mediumFamily = 'Poppins-Medium';
const semiBoldFamily = 'Poppins-SemiBold';
const boldFamily = 'Poppins-Bold';

class TextStyles {
  static const tiny = TextStyle(fontSize: 12, fontFamily: regularFamily);
  static const small = TextStyle(fontSize: 14, fontFamily: mediumFamily);
  static const regular = TextStyle(fontSize: 16, fontFamily: regularFamily);
  static const medium = TextStyle(fontSize: 17, fontFamily: mediumFamily);
  static const semiBold = TextStyle(fontSize: 18, fontFamily: semiBoldFamily);
  static const bold = TextStyle(fontSize: 18, fontFamily: boldFamily);
  static const extraBold = TextStyle(fontSize: 20, fontFamily: boldFamily);
}
