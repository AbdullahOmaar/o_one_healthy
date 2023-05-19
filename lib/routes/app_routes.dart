import 'package:app/screens/home_screen/view/home_screen.dart';
import 'package:app/screens/patients/patients_file/view/patients_files_screen.dart';

import '../screens/ads_screen/view/ads_screen.dart';
import '../screens/doctor_dashboard_screen/view/dashboard_screen.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/subscribers_screen/view/subscribers_screen.dart';

class AppRoutes {
  static const home = HomeScreen.routeName;
  static const doctorDashboard = DashboardScreen.routeName;
  static const adsScreen = AdsScreen.routeName;
  static const loginScreen = LoginScreen.routeName;
  static const subscribersScreen = SubscribersScreen.routeName;
  static const patientFileScreen = PatientFileScreen.routeName;
  // static const screenName = screenName.routeName;
}
