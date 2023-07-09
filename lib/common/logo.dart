import 'package:flutter/material.dart';

Widget appLogo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Stack(
        alignment: const AlignmentDirectional(.9, 4.5),
        children: [
          Image.asset(
            "assets/images/logo/doctor.png",
            width: 70,
            height: 110,
          ),
          Image.asset(
            "assets/images/logo/logopp2.png",
            width: 190,
            height: 90,
          ),
        ],
      ),
    ],
  );
}
