import 'dart:convert';
import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.01,
            0.4,
            0.6,
          ],
          colors: [
            Colors.red,
            Colors.indigo,
            Colors.teal,
          ],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await storage.delete(key: 'userSession');
                          await storage.delete(key: 'currentUser');
                          Navigator.of(context).pushAndRemoveUntil(
                            RouteGenerator.generateRoute(
                                const RouteSettings(name: AppRoutes.home)),
                            (route) => false,
                          );
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 40,
                          color: Colors.grey,
                        )),
                    CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            Image.asset('assets/images/logo/logo.jpeg').image),
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Text(
                  user?.name ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      children: [
                        makeDashboardItem("Users", Icons.person_2_outlined, () {
                          Navigator.of(context).pushAndRemoveUntil(
                            RouteGenerator.generateRoute(const RouteSettings(
                                name: AppRoutes.usersScreen)),
                            (route) => false,
                          );
                        }),
                        makeDashboardItem(
                            "Patients", Icons.medical_information_outlined, () {
                          Navigator.of(context).pushAndRemoveUntil(
                            RouteGenerator.generateRoute(const RouteSettings(
                                name: AppRoutes.patientScreen)),
                            (route) => false,
                          );
                        }),
                        makeDashboardItem("Subscribers", Icons.feed_outlined,
                            () {
                          Navigator.of(context).pushAndRemoveUntil(
                            RouteGenerator.generateRoute(const RouteSettings(
                                name: AppRoutes.subscribersScreen)),
                            (route) => false,
                          );
                        }),
                        makeDashboardItem("Requests", Icons.local_hospital, () {
                          Navigator.of(context).pushAndRemoveUntil(
                            RouteGenerator.generateRoute(const RouteSettings(
                                name: AppRoutes.subscribeRequestsScreen)),
                            (route) => false,
                          );
                        }),
                      ]),
                ),
              ),
            ),
          ],
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

  Card makeDashboardItem(String title, IconData icon, Function() onTap) {
    return Card(
        elevation: 0.0,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Icon(
                    icon,
                    size: 35.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  AutoSizeText(title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.black))
                ],
              ),
            ),
          ),
        ));
  }
}
