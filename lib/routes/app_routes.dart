import 'package:app/screens/ads_screen/view/ads_screen.dart';
import 'package:app/screens/doctor_dashboard_screen/view/dashboard_screen.dart';
import 'package:app/screens/doctor_dashboard_screen/view/doctor_dashboard.dart';
import 'package:app/screens/home/view/home_screen.dart';
import 'package:app/screens/login/view/login_screen.dart';
import 'package:app/screens/patients/patients_file/view/patients_files_screen.dart';
import 'package:app/screens/patients/patients_files_search/view/patients_files_search.dart';
import 'package:app/screens/profile/view/profile.dart';
import 'package:app/screens/sections/view/sections_screen.dart';
import 'package:app/screens/splash/view/splash_screen.dart';
import 'package:app/screens/subscribers_requests/view/subscribers_requests.dart';
import 'package:app/screens/subscribers_screen/view/subscribers_screen.dart';
import 'package:app/screens/user_details/view/user_details.dart';

class AppRoutes {
  static const kSplash = SplashScreen.routeName;
  static const home = HomeScreen.routeName;
  static const doctorDashboard = DashboardScreen.routeName;
  static const adsScreen = AdsScreen.routeName;
  static const loginScreen = LoginScreen.routeName;
  static const subscribersScreen = SubscribersScreen.routeName;
  static const patientFileScreen = PatientFileScreen.routeName;
  static const usersScreen = DoctorDashboard.routeName;
  static const patientsDashboard = PatientsFilesSearch.routeName;
  static const subscribeRequestsScreen = SubscriberRequests.routeName;
  static const userDetailsScreen = UserDetailsScreen.routeName;
  static const sectionsScreen = SectionsScreen.routeName;
  static const profileScreen = ProfileScreen.routeName;
}
