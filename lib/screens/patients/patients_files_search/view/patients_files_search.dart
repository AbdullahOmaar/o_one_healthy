import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/doctor_dashboard_screen/models/user_data_model.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/screens/patients/patients_files_search/view/widget/patient_card.dart';
import 'package:app/screens/patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

class PatientsFilesSearch extends ConsumerStatefulWidget {
  const PatientsFilesSearch({super.key});
  static const routeName = "/PatientsFilesSearch";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PatientsDashboardState();
}

class _PatientsDashboardState extends ConsumerState<PatientsFilesSearch> {
  TextEditingController searchPatientTextController = TextEditingController();
  List<Patient>? allPatients;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  User? user;

  @override
  void initState() {
    fetchPatientsData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allPatients = ref.watch(patientFSViewModelProvider).patients;
    fetchPatientsData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant PatientsFilesSearch oldWidget) {
    fetchPatientsData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      appBar: baseAppBar(context, "", profileImage: Images.profile),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "welcome".tr(),
            style: tsS16W800CkPrimary,
          ),
          Dimens.vMargin2,
          Text(
            "have_nice_day".tr(),
            style: tsS14W700CkBlack,
          ),
          Dimens.vMargin2,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.w,
                child: TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    suffixIcon: Icon(Icons.clear, color: ThemeColors.iconColor),
                    prefixIcon:
                        Icon(Icons.search, color: ThemeColors.iconColor),
                    labelText: "search".tr(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: ThemeColors.kPrimary)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: ThemeColors.kPrimary),
                    ),
                  ),
                  onChanged: (String val) {
                    searchPatients(val);
                  },
                ),
              ),
              Dimens.hMargin2,
              ElevatedButton(
                  onPressed: () {},
                  child: Image.asset(
                    Images.add,
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.bgColor,
                      shape: CircleBorder(),
                      fixedSize: Size(50, 50))),
            ],
          ),
          Dimens.vMargin2,
          allPatients != []
              ? Container(
                  height: 50.h,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: allPatients!.length,
                      itemBuilder: (ctx, index) {
                        final Patient patient = allPatients![index];
                        return PatientCard(patient: patient);
                      },
                    ),
                  ),
                )
              : Center(
                  child: Text("no data found"),
                ),
        ],
      ),
    );
  }

  void searchPatients(String query) {
    if (query.isNotEmpty) {
      final suggestions = ref
          .watch(patientFSViewModelProvider)
          .patients
          .where((Patient patient) {
        final patientNameEN = patient.nameEN.toLowerCase();
        final patientNameAR = patient.nameAR.toLowerCase();
        final patientUID = patient.uid.toLowerCase();
        final input = query.toLowerCase();
        return patientNameEN.contains(input) ||
            patientNameAR.contains(input) ||
            patientUID.contains(input);
      }).toList();
      setState(() {
        allPatients = suggestions;
      });
    } else {
      setState(() {
        allPatients = ref.watch(patientFSViewModelProvider).patients;
      });
    }
  }

  fetchPatientsData() async {
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  }
}
