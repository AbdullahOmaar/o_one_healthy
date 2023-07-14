import 'package:app/common/widget_utils.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget solidButton(
    {required Function() onPressed,
    required String text,
    Color? backgroundColor,
    String? image}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ThemeColors.kPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: const Size.fromHeight(58),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: tsS14W700CkBlack,
              ),
            ),
            image != null ? const Spacer() : Container(),
            image != null
                ? Image.asset(
                    image ?? '',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  )
                : const Spacer(),
          ],
        ),
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
