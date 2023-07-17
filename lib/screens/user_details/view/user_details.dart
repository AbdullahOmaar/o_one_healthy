import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/common/widgets/text_widget.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/user_details/model/user_details_model.dart';
import 'package:app/screens/user_details/view/widget/user_header_card.dart';
import 'package:app/screens/user_details/view_model/user_details_view_model.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = "/UserDetailsScreen";

  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  UserDataModel userData = userDetails;
  String title = "";
  double _rating = 0;
  // bool isWork = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        bottomNavigationBar: const CustomBottomBarWidget(),
        appBar: baseAppBar(context, title, profileImage: Images.profile),
        body: body());
  }

  body() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserHeaderCard(userData: userData),
            Dimens.vMargin2,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ThemeColors.kLightBlue),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "details.evaluation".tr(),
                          style: tsS12W600CKmob,
                        ),
                        RatingBar.builder(
                          itemSize: 30.0,
                          initialRating: userData.rating ?? 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                      ],
                    ),
                    Dimens.hMargin6,
                    Container(
                        width: 4.0,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ThemeColors.kSperator)),
                    Dimens.hMargin6,
                    Column(
                      children: [
                        Text(
                          "details.experience".tr(),
                          style: tsS12W600CKmob,
                        ),
                        Text(
                          "${userData.experience}${"details.year".tr()}",
                          style: tsS12W500CkBlack,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Dimens.vMargin2,
            Text(
              "details.detail".tr(),
              style: tsS14W800CkBlack,
            ),
            Text(userData.details ?? '',
                style: tsS12W500CkBlack,
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
            getVerticalSpacerLine(double.infinity, CustomWidth.matchParent,
                ThemeColors.kSperator, 12.0),
            Text(
              "details.appointments".tr(),
              style: tsS14W800CkBlack,
            ),
            Dimens.vMargin2,
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              makeAppointmentWidget("days.saturday".tr(), tsS16W500CkLightBlue,
                  ThemeColors.kPrimary),
              makeAppointmentWidget(
                  "days.sunday".tr(), tsS16W500CkPrimary, Colors.grey.shade300),
              makeAppointmentWidget("days.monday".tr(), tsS16W500CkLightBlue,
                  ThemeColors.kPrimary),
              makeAppointmentWidget("days.tuesday".tr(), tsS16W500CkLightBlue,
                  ThemeColors.kPrimary),
              makeAppointmentWidget("days.wednesday".tr(), tsS16W500CkPrimary,
                  Colors.grey.shade300),
            ]),
            Dimens.vMargin2,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "details.from".tr(),
                  style: tsS16W500CkPrimary,
                ),
                makeAppointmentWidget(
                  "${userData.fromTime}${"details.am".tr()}",
                  tsS16W500CkLightBlue,
                  ThemeColors.kPrimary,
                ),
                Text(
                  "details.to".tr(),
                  style: tsS16W500CkPrimary,
                ),
                makeAppointmentWidget(
                  "${userData.toTime}${"details.pm".tr()}",
                  tsS16W500CkLightBlue,
                  ThemeColors.kPrimary,
                ),
                Dimens.vMargin2,
              ],
            ),
            Dimens.vMargin2,
            getVerticalSpacerLine(double.infinity, CustomWidth.matchParent,
                ThemeColors.kSperator, 12.0),
            Dimens.vMargin2,
            Row(
              children: [
                Image.asset(Images.patientesFiles),
                Dimens.hMargin2,
                Text(
                  "${userData.files}${"details.file".tr()}",
                  style: tsS14W700CkBlack,
                ),
              ],
            ),
            Dimens.vMargin2,
            Row(
              children: [
                Image.asset(Images.patientesNum),
                Dimens.hMargin2,
                Text(
                  "${userData.patient}${"details.patient".tr()}",
                  style: tsS14W700CkBlack,
                ),
              ],
            ),
          ],
        ),
      );

  Widget makeAppointmentWidget(String day, TextStyle style, Color color,
      {double? width, double? height}) {
    return Container(
      width: 15.w,
      height: 8.h,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: UiText(
          text: day,
          style: style,
        ),
      ),
    );
  }
}
