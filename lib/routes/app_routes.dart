import 'package:app/screens/home/view/home_screen.dart';
import 'package:app/screens/patients/patients_file/view/patients_files_screen.dart';
import 'package:app/screens/sections/view/sections_screen.dart';
import 'package:app/screens/splash/view/splash_screen.dart';
import 'package:app/screens/user_details/view/user_details.dart';
import '../screens/ads_screen/view/ads_screen.dart';
import '../screens/doctor_dashboard_screen/view/dashboard_screen.dart';
import '../screens/doctor_dashboard_screen/view/doctor_dashboard.dart';
import '../screens/doctor_dashboard_screen/view/patients_dashboard.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/subscribers_requests/view/subscribers_requests.dart';
import '../screens/subscribers_screen/view/subscribers_screen.dart';

class AppRoutes {
  static const kSplash = SplashScreen.routeName;
  static const home = HomeScreen.routeName;
  static const doctorDashboard = DashboardScreen.routeName;
  static const adsScreen = AdsScreen.routeName;
  static const loginScreen = LoginScreen.routeName;
  static const subscribersScreen = SubscribersScreen.routeName;
  static const patientFileScreen = PatientFileScreen.routeName;
  static const usersScreen = DoctorDashboard.routeName;
  static const patientScreen = PatientsDashboard.routeName;
  static const subscribeRequestsScreen = SubscriberRequests.routeName;
  static const userDetailsScreen = UserDetailsScreen.routeName;
  static const sectionsScreen = SectionsScreen.routeName;

  // static const screenName = screenName.routeName;
}
