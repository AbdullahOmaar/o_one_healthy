import 'package:app/common/custom_button.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/doctor_dashboard_screen/models/user_data_model.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/screens/patients/patients_files_search/view/widget/patient_card.dart';
import 'package:app/screens/patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: baseAppBar(context, "search"),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 70.w,
                child: TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    suffixIcon: Icon(Icons.clear),
                    prefixIcon: Icon(Icons.search),
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
              SizedBox(
                  width: 40, child: solidButton(onPressed: () {}, text: "text"))
            ],
          ),
          Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              height: MediaQuery.of(context).size.height * 0.80,
              child: Expanded(
                child: ListView.builder(
                  itemCount: allPatients!.length,
                  itemBuilder: (ctx, index) {
                    final Patient patient = allPatients![index];

                    return PatientCard(patient: patient);
                  },
                ),
              )
              //   ],
              // ),
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
