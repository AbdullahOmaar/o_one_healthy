import 'package:app/common/widget_utils.dart';
import 'package:app/util/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget solidButton(
    {required onPressed,
    required String text,
    Color? backgroundColor,
    required Icon icon}) {
  return ElevatedButton.icon(
      onPressed: () {
        onPressed;
      },
      icon: icon,
      label: Text(
        text,
        style: tsS12W700CkPrimary,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        minimumSize: const Size.fromHeight(50),
      ));
}

//TODO delete
enum CustomWidth { oneThird, twoThird, half, matchParent }

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final double fontSize;
  double? iconSize;
  final CustomWidth btnWidth;
  double? width;
  double? height;
  late double fullWidth;
  final IconData? icon;
  CustomButton(
      {Key? key,
      this.text,
      this.width,
      this.height,
      this.iconSize,
      required this.fontSize,
      required this.onPressed,
      required this.btnWidth,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    fullWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ?? getWidgetWidth(fullWidth, btnWidth),
      height: height,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23.0))),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Text(
              text ?? '',
              style: TextStyle(fontSize: fontSize),
            ),
            if (icon != null)
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
