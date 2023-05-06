import 'package:flutter/material.dart';

enum BtnWidth {oneThird ,twoThird , half , matchParent}
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed ;
  final double fontSize;
  final BtnWidth btnWidth;
  late double fullWidth;
  CustomButton({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.onPressed,
    required this.btnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     fullWidth =MediaQuery.of(context).size.width;
    return SizedBox(
      width: getBtnWidth(),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.indigo,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
  double getBtnWidth(){
    switch(btnWidth){
      case BtnWidth.oneThird :
        return fullWidth *0.33;
      case BtnWidth.twoThird:
        return fullWidth * 0.66;
      case BtnWidth.half:
        return fullWidth * 0.50;
      case BtnWidth.matchParent:
        return fullWidth ;
      default :
        return fullWidth;
    }
  }
}
