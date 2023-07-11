import 'package:app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget appLogo({String? logo}) {
  return SizedBox(
    height: 20.h,
    width: 224.w,
    child: Image.asset(
      logo ?? Images.appLogo,
    ),
  );
}
