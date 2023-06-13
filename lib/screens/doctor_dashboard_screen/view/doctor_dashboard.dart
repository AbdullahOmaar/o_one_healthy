import 'dart:convert';

import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/create_user_form.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/filter_text_btn.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/user_card.dart';
import 'package:app/screens/doctor_dashboard_screen/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
import '../models/user_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorDashboard extends ConsumerStatefulWidget {
  const DoctorDashboard({super.key});
  static const routeName = "/DoctorScreen";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDashboardState();
}

class _DoctorDashboardState extends ConsumerState<DoctorDashboard> {
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
    allUsers = ref.watch(dashboardViewModelProvider).users ?? [];

    fetchUsersData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DoctorDashboard oldWidget) {
    getCurrentUserData();
    fetchUsersData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (searchUserTextController.text.isEmpty &&
        (!isAdminToggled && !isPharmacyToggled)) {
      allUsers = ref.watch(dashboardViewModelProvider).users;
    }

    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    customWidth: CustomWidth.twoThird,
                    controller: searchUserTextController,
                    inputType: TextInputType.text,
                    labelText: 'Search users',
                    isPassword: false,
                    fieldBorder: FieldBorder.custom,
                    onChanged: searchUser,
                    suffix: Icons.search,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CustomButton(
                    width: 63.0,
                    height: 60,
                    btnWidth: CustomWidth.oneThird,
                    fontSize: 22,
                    icon: Icons.add,
                    iconSize: 30,
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45))),
                          constraints: BoxConstraints(
                              minHeight: 200,
                              maxHeight: MediaQuery.of(context).size.height,
                              minWidth: 100,
                              maxWidth: 1100),
                          context: context,
                          builder: (context) => const CreateUserForm());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: ToggleButtons(
                      fillColor: Colors.indigo,
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      isSelected: [
                        isAdminToggled,
                        isPharmacyToggled,
                      ],
                      onPressed: (i) {
                        switch (i) {
                          case 0:
                            isAdminToggled = !isAdminToggled;
                            break;
                          case 1:
                            isPharmacyToggled = !isPharmacyToggled;
                            break;
                        }
                        toggleFilter();
                      },
                      children: [
                        FilterTextShape(text: 'is admin'),
                        FilterTextShape(text: 'is Pharmacy'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allUsers!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final User user = allUsers![index];
                        return UserCard(user: user);
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

  void searchUser(String query) {
    if (query.isNotEmpty) {
      final suggestions =
          ref.watch(dashboardViewModelProvider).users.where((User user) {
        final userName = user.name.toLowerCase();
        final userID = user.uid.toLowerCase();
        final input = query.toLowerCase();
        return userName.contains(input) || userID.contains(input);
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

  fetchUsersData() async {
    await ref.read(dashboardViewModelProvider.notifier).getUsersList();
  }
}
