import 'dart:convert';
import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../routes/app_routes.dart';
import '../models/user_data_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = "/DoctorDashboardScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DashboardScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  List<User>? allUsers;
  User? user;
  String title = "";

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    getCurrentUserData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        bottomNavigationBar: const CustomBottomBarWidget(),
        padding: const EdgeInsets.all(12.0),
        appBar: baseAppBar(context, title, profileImage: Images.profile),
        body: body());
  }

  body() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "dashboard.services".tr(),
            style: tsS16W500CkPrimary,
          ),
          Image.asset(
            Images.adsImg,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .22,
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                children: [
                  makeDashboardItem("dashboard.patients".tr(), Images.patientes,
                      AppRoutes.patientsDashboard),
                  makeDashboardItem("dashboard.users".tr(), Images.users,
                      AppRoutes.usersScreen),
                  makeDashboardItem("dashboard.ads".tr(), Images.ads,
                      AppRoutes.subscribeRequestsScreen),
                  makeDashboardItem("dashboard.subscribers".tr(),
                      Images.subscribers, AppRoutes.subscribersScreen),
                ]),
          ),
        ],
      );

  getCurrentUserData() async {
    String? data = await storage.read(
      key: 'currentUser',
    );
    user = User.fromJson(json.decode(data ?? ''));
  }

  Widget makeDashboardItem(String title, String image, routeName) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, routeName);
      },
      child: Card(
          elevation: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width * .01,
            height: MediaQuery.of(context).size.height * .01,
            decoration: BoxDecoration(
                color: ThemeColors.kPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * .05),
                Image.asset(
                  image,
                  width: 70,
                  height: 70,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * .01),
                AutoSizeText(title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: tsS14W700CkBlack)
              ],
            ),
          )),
    );
  }
}
