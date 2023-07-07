import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({this.message = "Loading...", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(20.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        content: SizedBox(
          width: 100.w,
          height: 100.h,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
