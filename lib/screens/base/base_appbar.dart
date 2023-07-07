import 'package:app/routes/app_routes.dart';
import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget baseAppBar(context, String tittle) {
  return AppBar(
    title: Text(
      tittle,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsetsDirectional.only(start: 18.w),
      child: Navigator.canPop(context)
          ? IconButton(
              onPressed: () async {
                Navigator.maybePop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ThemeColors.kPrimary,
              ),
            )
          : IconButton(
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.home, (r) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ThemeColors.kPrimary,
              ),
            ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
