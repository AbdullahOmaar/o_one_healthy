import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/bottom_bar/bottombar_view_model/bottomBar_view_model.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_page/search_page.dart';

import '../../../common/custom_button.dart';
import '../../patients_files_search/models/patient_model.dart';
import '../../patients_files_search/view/patients_files_search.dart';
import '../../patients_files_search/view_model/patients_files_search_view_model.dart';

class DoctorDashboardScreen extends ConsumerStatefulWidget {
  const DoctorDashboardScreen({Key? key}) : super(key: key);
  static const routeName = "/DoctorDashboardScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DoctorDashboardScreen> {
  @override
  void initState() {
    fetchPatientData();
    super.initState();
  }
  @override
  void didUpdateWidget(covariant DoctorDashboardScreen oldWidget) {
    fetchPatientData();

    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(
    BuildContext context,
  ) {
    return  Scaffold(
      // bottomNavigationBar: const CustomBottomBarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(btnWidth: BtnWidth.half,fontSize: 18,onPressed: (){
              showSearch(
                useRootNavigator: true,
                context: context,
                delegate:getSearchPage(ref,context,ref.watch(patientFSViewModelProvider).patients),
              );
            },text: 'search',icon: Icons.search,),
            getVerticalSpacerWidget(context),
            CustomButton(
              btnWidth: BtnWidth.twoThird,
              fontSize: 18,
              onPressed: () {
              },
              text: 'Create patient file',
            ),
          ],
        ),
      ),
    );
  }
  fetchPatientData()async{
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  }
}

