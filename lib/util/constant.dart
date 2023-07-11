import 'package:flutter/material.dart';

enum Lang {
  ar('عربي'),
  en("English");

  final String? title;

  const Lang(this.title);
}

class Themes {
  static const kPrimaryColor = 0xffB9CC97;
  static const kPrimaryTextColor = 0xff23282D;
  static const kPrimaryBackGroundColor = Color(0xffFDFDFD);
  static const kScreenBackGroundColor = Color(0xffDBDBDB);
  static const kPrimarySwatch = MaterialColor(kPrimaryColor, {
    50: Color(kPrimaryColor),
    100: Color(kPrimaryColor),
    200: Color(kPrimaryColor),
    300: Color(kPrimaryColor),
    400: Color(kPrimaryColor),
    500: Color(kPrimaryColor),
    600: Color(kPrimaryColor),
    700: Color(kPrimaryColor),
    800: Color(kPrimaryColor),
    900: Color(kPrimaryColor)
  });

  static const kFontFamily = 'CairoRegular';
}

class Images {
  static const appLogo = 'assets/images/logo/app_logo.png';
}
