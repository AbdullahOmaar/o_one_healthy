import 'package:flutter/material.dart';

enum Lang {
  ar('عربي'),
  en("English");

  final String? title;

  const Lang(this.title);
}

class Themes {
  static const kPrimaryColor = 0xffb49164;
  static const kPrimaryTextColor = 0xff23282D;
  static const kPrimaryBackGroundColor = Color(0xffFDFDFD);
  static const kScreenBackGroundColor = Color(0xffDBDBDB);

  static const kFontFamily = 'CairoRegular';
}
