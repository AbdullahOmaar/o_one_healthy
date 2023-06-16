import 'package:app/screens/doctor_dashboard_screen/view/widgets/create_patient_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/custom_button.dart';
import '../../../common/custom_text_field/custom_text_field.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
import '../../patients/patients_files_search/models/patient_model.dart';
import '../../patients/patients_files_search/view/patients_files_search.dart';
import '../../patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import '../models/user_data_model.dart';

class PatientsDashboard extends ConsumerStatefulWidget {
  const PatientsDashboard({super.key});
  static const routeName = "/PatientScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PatientsDashboardState();
}

class _PatientsDashboardState extends ConsumerState<PatientsDashboard> {
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
  void didUpdateWidget(covariant PatientsDashboard oldWidget) {
    fetchPatientsData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                RouteGenerator.generateRoute(
                    const RouteSettings(name: AppRoutes.doctorDashboard)),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white70,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: searchPatientTextController,
                    customWidth: CustomWidth.twoThird,
                    inputType: TextInputType.text,
                    labelText: 'Search patients',
                    isPassword: false,
                    fieldBorder: FieldBorder.custom,
                    onChanged: (String val) {
                      searchPatients(val);
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .02,
                  ),
                  CustomButton(
                    btnWidth: CustomWidth.oneThird,
                    width: 63.0,
                    height: 60.0,
                    fontSize: 18,
                    icon: Icons.add,
                    iconSize: 30,
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45))),
                          constraints: BoxConstraints(
                              minHeight: 200,
                              maxHeight: MediaQuery.of(context).size.height,
                              minWidth: 100,
                              maxWidth: 1100),
                          context: context,
                          builder: (context) => const CreatePatientForm());
                    },
                  ),
                ],
              ),
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
