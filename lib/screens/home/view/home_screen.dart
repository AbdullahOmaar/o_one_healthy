import 'package:app/common/custom_button.dart';
import 'package:app/common/logo.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Patient> patients = [];
  @override
  void initState() {
    // fetchPatientData();
    super.initState();
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    // fetchPatientData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // fetchPatientData();
    // patients = ref.watch(patientFSViewModelProvider).patients;
    return BaseScaffold(body: body());
  }

  body() => Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appLogo(),
              solidButton(
                  onPressed: () {},
                  text: "text",
                  icon: const Icon(Icons.image_search_rounded)),
              solidButton(
                  onPressed: () {},
                  text: "text",
                  icon: const Icon(Icons.image_search_rounded))
            ],
          ),
        ),
      );

  // fetchPatientData() async {
  //   await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  // }
}

//TODO delete
// @override
// Widget build(BuildContext context) {
//   fetchPatientData();
//   patients = ref.watch(patientFSViewModelProvider).patients;
//   return Scaffold(
//     // bottomNavigationBar: const CustomBottomBarWidget(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.80,
//                 height: MediaQuery.of(context).size.height * 0.20,
//                 child: Image.asset(
//                   'assets/images/logo/logo.jpeg',
//                   fit: BoxFit.fill,
//                 )),
//             getVerticalSpacerWidget(context),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: FilledButton(
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                 ),
//                 onPressed: () {
//                   showSearch(
//                     useRootNavigator: true,
//                     context: context,
//                     delegate: SearchPage<Patient>(
//                       items: patients,
//                       onQueryUpdate: (_) {
//                         fetchPatientData();
//                         patients = ref.watch(patientFSViewModelProvider).patients;
//                       },
//                       searchLabel: 'Search people',
//                       searchStyle: const TextStyle(color: Colors.white),
//                       barTheme: Theme.of(context).copyWith(
//                         appBarTheme:
//                         const AppBarTheme(backgroundColor: Colors.indigo),
//                         inputDecorationTheme: const InputDecorationTheme(
//                           focusedErrorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       suggestion: const Center(
//                         child: Text('Filter people by name, surname or ID'),
//                       ),
//                       failure: const Center(
//                         child: Text('No person found :('),
//                       ),
//                       filter: (patient) => [
//                         patient.nameEN,
//                         patient.nameAR,
//                         patient.uid.toString(),
//                       ],
//                       builder: (patient) => PatientCard(
//                         patient: patient,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Patients Files',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             getVerticalSpacerWidget(context),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: FilledButton(
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                 ),
//                 onPressed: () async {
//                   const FlutterSecureStorage storage = FlutterSecureStorage();
//                   String session = await storage.read(key: 'userSession') ?? '';
//                   print('session $session');
//                   if (session.isEmpty) {
//                     Navigator.of(context).pushAndRemoveUntil(
//                       MaterialPageRoute(builder: (ctx) => const LoginScreen()),
//                           (route) => false,
//                     );
//                   } else {
//                     Navigator.of(context).pushAndRemoveUntil(
//                       RouteGenerator.generateRoute(
//                           const RouteSettings(name: AppRoutes.doctorDashboard)),
//                           (route) => false,
//                     );
//                   }
//                 },
//                 child: const Text(
//                   'Login now',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             getVerticalSpacerWidget(context),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: FilledButton(
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'subscription',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             getVerticalSpacerWidget(context),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: FilledButton(
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'ADS',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             getVerticalSpacerWidget(context),
//             getVerticalSpacerWidget(context),
//             getVerticalSpacerWidget(context),
//             const Text(
//               'واذا مرضت فهو يشفين',
//               style: TextStyle(fontSize: 30),
//             ),
//           ],
//         ),
//       ));
// }
