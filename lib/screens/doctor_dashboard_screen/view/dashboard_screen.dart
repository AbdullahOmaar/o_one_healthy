import 'dart:convert';

import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
import '../../patients/patients_files_search/models/patient_model.dart';
import '../models/user_data_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = "/DoctorDashboardScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DashboardScreen> {
  TextEditingController searchUserTextController = TextEditingController();
  TextEditingController searchPatientTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  List<User>? allUsers;
  List<Patient>? allPatients;
  User? user;
  bool isAdminToggled = false;
  bool isPharmacyToggled = false;

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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await storage.delete(key: 'userSession');
                                await storage.delete(key: 'currentUser');
                                Navigator.of(context).pushAndRemoveUntil(
                                  RouteGenerator.generateRoute(
                                      const RouteSettings(
                                          name: AppRoutes.home)),
                                  (route) => false,
                                );
                              },
                              icon: const Icon(
                                Icons.menu,
                                size: 40,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .007,
                          ),
                          Text(
                            user?.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              Image.asset('assets/images/logo/logo.jpeg').image)
                    ],
                  )),

              CustomButton(
                btnWidth: CustomWidth.twoThird,
                fontSize: 18,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    RouteGenerator.generateRoute(
                        const RouteSettings(name: AppRoutes.usersScreen)),
                    (route) => false,
                  );
                },
                text: 'Create new user',
              ),
              CustomButton(
                btnWidth: CustomWidth.twoThird,
                fontSize: 18,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    RouteGenerator.generateRoute(
                        const RouteSettings(name: AppRoutes.patientScreen)),
                    (route) => false,
                  );
                },
                text: 'Create new patient',
              ),
              CustomButton(
                btnWidth: CustomWidth.twoThird,
                fontSize: 18,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    RouteGenerator.generateRoute(
                        const RouteSettings(name: AppRoutes.subscribersScreen)),
                    (route) => false,
                  );
                },
                text: 'Subscribers',
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCurrentUserData() async {
    String? data = await storage.read(
      key: 'currentUser',
    );
    user = User.fromJson(json.decode(data ?? ''));
  }
}
