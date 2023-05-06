import 'package:app/common/widget_utils.dart';
import 'package:app/screens/login/view/login_screen.dart';
import 'package:app/screens/patients_files_search/view/patients_files_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_page/search_page.dart';

import '../../../common/custom_button.dart';
import '../../patients_files_search/models/patient_model.dart';
import '../../patients_files_search/view_model/patients_files_search_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    fetchPatientData();
    super.initState();
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    fetchPatientData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset(
                  'assets/images/logo/logo.jpeg',
                  fit: BoxFit.fill,
                )),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                  showSearch(
                    useRootNavigator: true,
                    context: context,
                    delegate: SearchPage<Patient>(
                      items: ref.watch(patientFSViewModelProvider).patients,
                      searchLabel: 'Search people',

                      suggestion: const Center(
                        child: Text('Filter people by name, surname or age'),
                      ),

                      failure: const Center(
                        child: Text('No person found :('),
                      ),
                      filter: (patient) => [
                        patient.nameEN,
                        patient.nameAR,
                        patient.uid.toString(),
                      ],
                      builder: (patient) =>PatientCard(patient: patient,)
                    ),
                  );

                },
                child: const Text('Patients Files',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                    // ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(0,SelectedScreen.login);
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const LoginScreen()),(route) => false,);
                },
                child: const Text('Login now',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                },
                child: const Text('subscription',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                },
                child: const Text('ADS',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            getVerticalSpacerWidget(context),
            getVerticalSpacerWidget(context),
            const Text('واذا مرضت فهو يشفين',style: TextStyle(fontSize: 30),),
          ],
        ),
      )
    );
  }
  fetchPatientData()async{
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  }
}

