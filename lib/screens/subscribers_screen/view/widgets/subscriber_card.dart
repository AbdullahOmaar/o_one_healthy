import 'dart:convert';

import 'package:app/common/widgets/text_widget.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../doctor_dashboard_screen/models/user_data_model.dart';

class SubscribersCard extends StatelessWidget {
  final User user;

  // final Patient user;
  TextEditingController userFilePasswordTEC = TextEditingController();
  Size? screenSize;
  SubscribersCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.userDetailsScreen);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          tileColor: ThemeColors.primary,
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: 1.0, horizontal: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              Images.docImg,
            ),
          ),
          title: UiText(
            text: user.name,
            style: tsS14W800CkBlack,
          ),
          subtitle: getUserDetailsBody(),
        ),
      ),
    );
  }

  getUserDetailsBody() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (user.privileges.hasAdsPrivileges)
              getPrivilegeChip("Control Ads"),
            if (user.privileges.isClinic) getPrivilegeChip("Clinic"),
            if (user.privileges.isDoctor) getPrivilegeChip("Doctor"),
            if (user.privileges.isPharmacy) getPrivilegeChip("Pharmacy"),
            if (user.privileges.isAdmin)
              getPrivilegeChip(
                "admin",
              ),
            if (user.privileges.isLaboratory) getPrivilegeChip("Lab"),
          ],
        ),
      );

  Widget getPrivilegeChip(
    String text,
  ) =>
      Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: Chip(
          clipBehavior: Clip.hardEdge,
          label: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 2,
          backgroundColor: Colors.white54,
        ),
      );

  Widget getUserNameTextWidget(
    String text,
  ) =>
      Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
      );
}
