import 'package:app/common/custom_button.dart';
import 'package:app/common/logo.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Patient> patients = [];

  String? bottomRadioValue = Lang.ar.name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        bottomRadioValue = context.locale.languageCode;
      });
    });
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
    return BaseScaffold(
      body: body(),
    );
  }

  body() => SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  child: TextButton(
                      onPressed: _changeLanguageBottomSheet(context, false),
                      child: Text(
                        bottomRadioValue!,
                        style: tsS14W700CkBlack,
                      )),
                ),
              ],
            ),
            Dimens.vMargin5,
            Column(
              children: [
                appLogo(),
                Dimens.vMargin5,
                solidButton(
                  onPressed: () {},
                  text: "home.patients_files".tr(),
                  image: "assets/images/icon/file.png",
                ),
                Dimens.vMargin5,
                solidButton(
                  onPressed: () {
                    buttonAction(AppRoutes.loginScreen);
                  },
                  text: "home.login".tr(),
                  image: "assets/images/icon/login.png",
                ),
                Dimens.vMargin5,
                solidButton(
                  onPressed: () {
                    buttonAction(AppRoutes.subscribersScreen);
                  },
                  text: "home.subscribers".tr(),
                  image: "assets/images/icon/subscribe.png",
                ),
                Dimens.vMargin5,
                solidButton(
                  onPressed: () {
                    buttonAction(AppRoutes.adsScreen);
                  },
                  text: "home.ads".tr(),
                  image: "assets/images/icon/ads.png",
                ),
                Dimens.vMargin8,
                const Text("وَإِذَا مَرِضْتُ فَهُوَ يَشْفِينِ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ],
        ),
      );

  // fetchPatientData() async {
  //   await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  // }

  void buttonAction(String route) {
    Navigator.pushNamed(context, route);
  }

  _changeLanguageBottomSheet(context, change) {
    setState(() {
      if (change == true) context.setLocale(Locale(Lang.ar.name));
    });

    // showModalBottomSheet(
    //     isScrollControlled: true,
    //     useSafeArea: true,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10.0.sp),
    //     ),
    //     context: context,
    //     builder: (BuildContext bc) {
    //       return FractionallySizedBox(
    //         heightFactor: 0.98,
    //         child: Column(
    //           children: [
    //             // bottomSheetHeader(
    //             //     context, "LocaleKeys.update_health_data.tr()"),
    //             Expanded(
    //               child: Container(),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }

  Widget bottomSheetHeader(BuildContext context, String headerText,
      {Function? clearAction}) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
          // color: Themes.kPrimaryBackGroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              spreadRadius: 2,
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                if (clearAction != null) clearAction();
                // Navigator.pop(context);
              },
              iconSize: 30.w,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          /* SizedBox(
          // width: getScreenWidth(context) * 0.2,
          width: 20.w,
        ),*/
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.h),
                    child: SizedBox(
                      width: 60.w,
                      child: Divider(
                        thickness: 3,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    headerText,
                    style: tsS12W700CkPrimary,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
          Dimens.hMargin35
        ],
      ),
    );
  }
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
