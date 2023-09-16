import 'dart:convert';

import 'package:app/common/roshata/widget/buldMedicalTestList.dart';
import 'package:app/common/roshata/widget/buld_medicines_list.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../screens/doctor_dashboard_screen/models/user_data_model.dart';
import '../../screens/patients/patients_file/patient_file_view_model/patients_file_view_model.dart';
import '../../screens/patients/patients_files_search/models/patient_model.dart';

class NewTestScreen extends ConsumerStatefulWidget {
  Patient patient;
  User user ;

   NewTestScreen({Key? key,required this.patient,required this.user}) : super(key: key);

  @override
  ConsumerState<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends ConsumerState<NewTestScreen> {
  final Map<String, bool> _map = {};
  MedicalTests medicalTests =MedicalTests();
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    widget.patient= ref.watch(fileViewModelProvider).currentPatient??widget.patient;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeColors.roshetaBG,
        border: Border.all(width: 2, color:ThemeColors.kPrimary),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDoctorHeaderDetails(),
             SizedBox(height: 30.h,
             child: Card(
              margin: EdgeInsets.all(8.0),
              child: BuildTestsList(isNewMedicalTests:true,medicalTests: medicalTests,patient:widget.patient,onTestUpdate: (List<Test> test){
                setState(() {
                  medicalTests.test=test;
                });
              },),
              color:Colors.white,
              shadowColor:Colors.grey.shade200,
              elevation: 1.0,
              shape:RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
              )),
            buildSaveButton()
            // buildDoctorFooterDetails()
          ],
        ),
      ),
    );
  }
  Widget buildSaveButton() {
    return SizedBox(
      width: 45.w,
      child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ThemeColors.kPrimary,),
          onPressed: () async{
            FlutterSecureStorage storage = const FlutterSecureStorage();
            String? data = await storage.read(
              key: 'currentUser',
            );
            if (data == null)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(child: Text('Please Login first')),
              ));
            else {
              User admin = User.fromJson(json.decode(data ?? ''));

              medicalTests.creator = admin;
              medicalTests.creationDate = DateTime.now().toString();
              await ref
                  .read(fileViewModelProvider.notifier)
                  .postPatientTests(widget.patient, medicalTests);
              Navigator.of(context).pop();
            }
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Save",
                style:tsS16W500CkLightBlue,
              ),
              Icon(Icons.add,color:ThemeColors.kLightBlue,),
            ],
          )
      ),
    );
  }

  Widget buildDoctorHeaderDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Images.profile,
                fit: BoxFit.fill,
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:  [
            Text("${"doctor".tr()}"": ${widget.user.name}",style: tsS12W500CkBlack,),
            Text("${"specialization".tr()}"":",style: tsS12W500CkBlack,),
          ],
        ),

      ],
    );
  }
}


/*Widget buildDoctorFooterDetails() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:  [
      Text("${"phone".tr()}"":  0100283043",style: tsS12W500CkBlack,),
      Text("${"adress".tr()}"":  الزقازيق",style: tsS12W500CkBlack,),
    ],
  );
}*/
