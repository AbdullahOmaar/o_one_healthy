import 'package:app/common/widget_utils.dart';
import 'package:flutter/material.dart';

enum CustomWidth {oneThird ,twoThird , half , matchParent}
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed ;
  final double fontSize;
  final CustomWidth btnWidth;
  late double fullWidth;
  final IconData? icon;
  CustomButton({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.onPressed,
    required this.btnWidth,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     fullWidth =MediaQuery.of(context).size.width;
    return SizedBox(
      width: getWidgetWidth(fullWidth,btnWidth),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.indigo,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: icon!=null?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: fontSize),

            ),
        if(icon != null)
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          ],
        ),
      ),
    );
  }

}
