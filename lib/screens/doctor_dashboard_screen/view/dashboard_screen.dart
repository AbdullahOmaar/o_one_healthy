import 'dart:convert';
import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
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
        appBar: AppBar(
          leading: IconButton(
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
          title: Text(
            user?.name ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54),
          ),
          actions: [
            CircleAvatar(
                radius: 30,
                backgroundImage:
                    Image.asset('assets/images/logo/logo.jpeg').image),
          ],
          backgroundColor: Colors.white,
          elevation: 2.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              children: [
                makeDashboardItem("Users", Icons.person_2_outlined, () {
                  Navigator.of(context).pushAndRemoveUntil(
                    RouteGenerator.generateRoute(
                        const RouteSettings(name: AppRoutes.usersScreen)),
                    (route) => false,
                  );
                }),
                makeDashboardItem(
                    "Patients", Icons.medical_information_outlined, () {
                  Navigator.of(context).pushAndRemoveUntil(
                    RouteGenerator.generateRoute(
                        const RouteSettings(name: AppRoutes.patientScreen)),
                    (route) => false,
                  );
                }),
                makeDashboardItem("Rosheta", Icons.feed_outlined, () {}),
                makeDashboardItem("Hosbital", Icons.local_hospital, () {}),
              ]),
        )

        //       Text(
        //         user?.name ?? '',
        //         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        //       ),

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                      child: Icon(
                    icon,
                    size: 40.0,
                    color: Colors.black,
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Center(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 25.0, color: Colors.black)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
