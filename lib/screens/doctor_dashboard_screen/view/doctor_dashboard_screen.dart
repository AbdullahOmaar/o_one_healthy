import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/create_user_form.dart';
import 'package:app/screens/patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              btnWidth: CustomWidth.half,
              fontSize: 18,
              onPressed: () {
                showSearch(
                  useRootNavigator: true,
                  context: context,
                  delegate: getSearchPage(ref, context,
                      ref.watch(patientFSViewModelProvider).patients),
                );
              },
              text: 'search',
              icon: Icons.search,
            ),
            getVerticalSpacerWidget(context),
            CustomButton(
              btnWidth: CustomWidth.half,
              fontSize: 18,
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    constraints: BoxConstraints(
                        minHeight: 200,
                        maxHeight: MediaQuery.of(context).size.height,
                        minWidth: 100,
                        maxWidth: 1100),
                    /*  constraints:  BoxConstraints.loose(Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.75)),*/

                    context: context,
                    builder: (context) => const CreateUserForm());
              },
              text: 'Create patient file',
            ),
          ],
        ),
      ),
    );
  }

  fetchPatientData() async {
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  }
}
