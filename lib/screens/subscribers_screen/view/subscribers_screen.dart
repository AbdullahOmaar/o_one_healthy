import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/widgets/text_widget.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/doctor_dashboard_screen/view_model/dashboard_view_model.dart';
import 'package:app/screens/subscribers_screen/view/widgets/subscribe_form.dart';
import 'package:app/screens/subscribers_screen/view/widgets/subscriber_card.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../common/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../doctor_dashboard_screen/models/user_data_model.dart';

class SubscribersScreen extends ConsumerStatefulWidget {
  const SubscribersScreen({super.key});

  static const routeName = "/subscribersScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubscribersScreenState();
}

class _SubscribersScreenState extends ConsumerState<SubscribersScreen> {
  TextEditingController searchUserTextController = TextEditingController();
  bool isAdminToggled = false;
  bool isPharmacyToggled = false;
  List<User>? allUsers;
  User? user;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    fetchUsersData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allUsers = getSubscribersList() ?? [];
    fetchUsersData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SubscribersScreen oldWidget) {
    fetchUsersData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    allUsers = getSubscribersList();

    return BaseScaffold(
      // backgroundColor: Colors.indigo.shade50,
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: body(),
    );
  }

  body() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // padding: const EdgeInsets.all(4),
              // margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              height: MediaQuery.of(context).size.height * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.vMargin5,
                  Row(
                    children: [
                      UiText(
                        text: "welcome".tr(),
                        style: tsS16W800CkPrimary,
                      ),
                      // UiText(
                      //   text: user?.name,
                      //   style: tsS14W800CkBlack,
                      // )
                    ],
                  ),
                  UiText(
                    text: "have_nice_day".tr(),
                    style: tsS12W500CkBlack,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allUsers!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        final User user = allUsers![index];
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userDetailsScreen);
                            },
                            child: SubscribersCard(user: user));
                      },
                    ),
                  )
                ],
              ),
            ),
            solidButton(
                // fontSize: 15,
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45))),
                      constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: MediaQuery.of(context).size.height,
                          minWidth: 100,
                          maxWidth: 1100),
                      context: context,
                      builder: (context) => const CreateSubscribeRequestForm());
                },
                // btnWidth: CustomWidth.twoThird,
                text: "Subscribe now!"),
          ],
        ),
      );

  List<User>? getSubscribersList() {
    fetchUsersData();
    return ref
        .watch(dashboardViewModelProvider)
        .users
        .where((user) =>
            user.privileges.isPharmacy ||
            user.privileges.isLaboratory ||
            user.privileges.isDoctor ||
            user.privileges.isClinic)
        .toList();
  }

  fetchUsersData() async {
    await ref.read(dashboardViewModelProvider.notifier).getUsersList();
  }
}
