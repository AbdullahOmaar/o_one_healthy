import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/bottom_bar/bottombar_view_model/bottomBar_view_model.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_page/search_page.dart';

import '../../patients_files_search/models/patient_model.dart';
import '../../patients_files_search/view/patients_files_search.dart';
import '../../patients_files_search/view_model/patients_files_search_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>    showSearch(
      useRootNavigator: true,
      context: context,
      delegate: SearchPage<Patient>(
        items: ref.watch(patientFSViewModelProvider).patients,
        searchLabel: 'Search people',
        searchStyle: const TextStyle(color: Colors.white),
        barTheme: Theme.of(context).copyWith(
          appBarTheme:const AppBarTheme(backgroundColor: Colors.indigo) ,
          inputDecorationTheme: const InputDecorationTheme(
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
        suggestion: const Center(
          child: Text('Filter people by name, surname or ID'),
        ),

        failure: const Center(
          child: Text('No person found :('),
        ),
        filter: (patient) => [
          patient.nameEN,
          patient.nameAR,
          patient.uid.toString(),
        ],
        builder: (patient) =>PatientCard(patient: patient,),
      ),
    ));
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;
    return const Scaffold(
      bottomNavigationBar: CustomBottomBarWidget(),
      body:Text('dashboard'),
    );
  }






}
