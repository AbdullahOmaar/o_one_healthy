import 'package:flutter/material.dart';

enum Lang {
  ar('عربي'),
  en("English");

  final String? title;

  const Lang(this.title);
}

class Themes {
  static const kPrimaryColor = 0xffB9CC97;
  static const kAppBackGroundColor = 0xffFFFFFB;
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
  static String profile = "assets/images/dashboard/profile.png";
  static String adsImg = "assets/images/dashboard/image.png";
  static String users = "assets/images/dashboard/users.png";
  static String patientes = "assets/images/dashboard/patientes.png";
  static String subscribers = "assets/images/dashboard/subscribers.png";
  static String ads = "assets/images/dashboard/adss.png";
  static String docImg = "assets/images/usersdetails/doctor.png";
  static String mob = "assets/images/usersdetails/mob.png";
  static String stars = "assets/images/usersdetails/stars.png";
  static String patientesFiles = "assets/images/usersdetails/patientfiles.png";
  static String patientesNum = "assets/images/usersdetails/hospitalisation.png";
  static String add = "assets/images/icon/add.png";

}
