import 'package:app/common/custom_button.dart';
import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class RootDialog extends StatelessWidget {
  const RootDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AlertDialog(
        contentPadding: EdgeInsets.all(20.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        content: SizedBox(
          width: 288.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/images/ic_warning.svg"),
              SizedBox(height: 20.h),
              SizedBox(
                width: 256.w,
                child: Text(
                  "Operators will not run on Rooted devices",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.kPrimaryText,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 122.w,
                child: solidButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  text: "Ok",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
