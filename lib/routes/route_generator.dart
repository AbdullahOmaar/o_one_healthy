import 'package:app/routes/app_routes.dart';
import 'package:app/screens/ads_screen/view/ads_screen.dart';
import 'package:app/screens/home_screen/view/home_screen.dart';
import 'package:app/screens/login/view/login_screen.dart';
import 'package:app/screens/subscribers_screen/view/subscribers_screen.dart';
import 'package:flutter/material.dart';

import '../screens/doctor_dashboard_screen/view/doctor_dashboard_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case AppRoutes.doctorDashboard:
        return buildRoute(const DoctorDashboardScreen(), settings: settings);
      case AppRoutes.adsScreen:
        return buildRoute(const AdsScreen(), settings: settings);
      case AppRoutes.loginScreen:
        return buildRoute(const LoginScreen(), settings: settings);
      case AppRoutes.subscribersScreen:
        return buildRoute(const SubscribersScreen(), settings: settings);
      // 1. Add screen ID in screen class:
      // static const routeName = '/SampleScreen';
      // 2. Add screen route ID in AppRoutes:
      // static const kSampleScreen = SampleScreen.routeName;
      // 3. To Navigate to SampleScreen:
      // Navigator.pushNamed(context, AppRoutes.kSample, arguments: ["hello SampleScreen"],);
      // 4. To read args inside SampleScreen:
      // final args = ModalRoute.of(context)!.settings.arguments;
      // return buildRoute(const SampleScreen(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.0,
                  // width: 200.0,
                  child: Image.asset('assets/images/logo/logo.jpeg'),
                ),
                const Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
