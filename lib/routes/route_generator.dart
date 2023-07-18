import 'package:app/routes/app_routes.dart';
import 'package:app/screens/ads_screen/view/ads_screen.dart';
import 'package:app/screens/home/view/home_screen.dart';
import 'package:app/screens/login/view/login_screen.dart';
import 'package:app/screens/patients/patientsFiles.dart';
import 'package:app/screens/patients/patients_file/view/patients_files_screen.dart';
import 'package:app/screens/sections/view/sections_screen.dart';
import 'package:app/screens/splash/view/splash_screen.dart';
import 'package:app/screens/user_details/view/user_details.dart';
import 'package:flutter/material.dart';
import '../screens/doctor_dashboard_screen/view/dashboard_screen.dart';
import '../screens/doctor_dashboard_screen/view/doctor_dashboard.dart';
import '../screens/doctor_dashboard_screen/view/patients_dashboard.dart';
import '../screens/subscribers_requests/view/subscribers_requests.dart';
import '../screens/subscribers_screen/view/subscribers_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.kSplash:
        return buildRoute(const SplashScreen(), settings: settings);
      case AppRoutes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case AppRoutes.doctorDashboard:
        return buildRoute(const DashboardScreen(), settings: settings);
      case AppRoutes.adsScreen:
        return buildRoute(const AdsScreen(), settings: settings);
      case AppRoutes.loginScreen:
        return buildRoute(const LoginScreen(), settings: settings);
      case AppRoutes.subscribersScreen:
        return buildRoute(const SubscribersScreen(), settings: settings);
      case AppRoutes.patientFileScreen:
        return buildRoute(const PatientFileScreen(), settings: settings);
      case AppRoutes.usersScreen:
        return buildRoute(const DoctorDashboard(), settings: settings);
      case AppRoutes.patientScreen:
        return buildRoute(const PatientsDashboard(), settings: settings);
      case AppRoutes.subscribeRequestsScreen:
        return buildRoute(const SubscriberRequests(), settings: settings);
      case AppRoutes.userDetailsScreen:
        return buildRoute(const UserDetailsScreen(), settings: settings);
      case AppRoutes.sectionsScreen:
        return buildRoute(const SectionsScreen(), settings: settings);
      case AppRoutes.patientsFiles:
        return buildRoute(const PatientsFiles(), settings: settings);  
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
        return null;
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
