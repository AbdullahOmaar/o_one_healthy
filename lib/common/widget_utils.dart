import 'package:app/common/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox getVerticalSpacerWidget(context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );

double getWidgetWidth(double fullWidth, CustomWidth customWidth) {
  switch (customWidth) {
    case CustomWidth.oneThird:
      return fullWidth * 0.33;
    case CustomWidth.twoThird:
      return fullWidth * 0.66;
    case CustomWidth.half:
      return fullWidth * 0.50;
    case CustomWidth.matchParent:
      return fullWidth;
    default:
      return fullWidth;
  }
}

Widget getVerticalSpacerLine(double fullWidth, CustomWidth customWidth,
        Color color, double padding) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // padding: EdgeInsets.all( padding),
        height: 3,
        width: getWidgetWidth(fullWidth, customWidth),
        color: color,
      ),
    );
