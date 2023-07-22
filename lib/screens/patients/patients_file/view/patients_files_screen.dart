import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/login/view/widgets/tabs.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:flutter/material.dart';

import '../../patients_files_search/models/patient_model.dart';

class PatientFileScreen extends StatelessWidget {
  static const routeName = "/PatientFileScreen";

  const PatientFileScreen({Key? key}) : super(key: key);
   

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      appBar: baseAppBar(context, "", profileImage: Images.profile),
      body: body(context),
    );
  }
  body(BuildContext context) {
       Patient patient = ModalRoute.of(context)!.settings.arguments as Patient;
    return Column(
      children: [
       Dimens.vMargin5,
       Expanded(child: FileTabs(patient:patient,),)
      ],
    );
  }
}
