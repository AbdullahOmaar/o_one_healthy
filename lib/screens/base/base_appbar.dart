import 'package:app/routes/app_routes.dart';
import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget baseAppBar(context, String tittle, {String? profileImage}) {
  return AppBar(
    title: Text(
      tittle,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsetsDirectional.only(start: 8.w),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.home);
        },
        icon: Icon(
          Icons.menu,
          color: ThemeColors.kBlack,
          size: 40,
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    actions: profileImage != null
        ? [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 8.w, start: 8),
              child: CircleAvatar(
                child: Image.asset(
                  profileImage ?? "",
                ),
              ),
            )
          ]
        : [],
  );
}
