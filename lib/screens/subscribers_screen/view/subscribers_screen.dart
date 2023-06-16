import 'dart:convert';


import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/user_card.dart';
import 'package:app/screens/doctor_dashboard_screen/view_model/dashboard_view_model.dart';
import 'package:app/screens/subscribers_screen/view/widgets/subscriber_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../common/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
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
    getCurrentUserData();
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
    getCurrentUserData();
    fetchUsersData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
      allUsers = getSubscribersList();

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      bottomNavigationBar: const CustomBottomBarWidget(),
      appBar: AppBar(
        leading: IconButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                RouteGenerator.generateRoute(
                    const RouteSettings(name: AppRoutes.doctorDashboard)),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white70,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(fontSize: 15, onPressed: () {   }, btnWidth: CustomWidth.twoThird,text: "Subscribe now!"),
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: allUsers!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final User user = allUsers![index];
                        return SubscribersCard(user: user);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  toggleFilter() {
    // if(query.isNotEmpty) {
    if (isAdminToggled || isPharmacyToggled) {
      final suggestions =
      ref.watch(dashboardViewModelProvider).users.where((User user) {
        final isAdmin = user.privileges.isAdmin;
        final isPharmacy = user.privileges.isPharmacy;
        // final input = query.toLowerCase();
        return (isAdminToggled && isAdmin) || (isPharmacyToggled && isPharmacy);
      }).toList();
      setState(() {
        allUsers = suggestions;
      });
    } else {
      setState(() {
        allUsers = ref.watch(dashboardViewModelProvider).users;
      });
    }
  }

  getCurrentUserData() async {
    String? data = await storage.read(
      key: 'currentUser',
    );
    user = User.fromJson(json.decode(data ?? ''));
  }
  List<User>? getSubscribersList(){
    return ref.watch(dashboardViewModelProvider).users.where((user) => user.privileges.isPharmacy
        ||user.privileges.isLaboratory||user.privileges.isDoctor||user.privileges.isClinic).toList();
  }


  fetchUsersData() async {
    await ref.read(dashboardViewModelProvider.notifier).getUsersList();
  }
}
