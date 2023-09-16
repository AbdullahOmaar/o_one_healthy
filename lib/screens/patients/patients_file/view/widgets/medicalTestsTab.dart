import 'dart:convert';

import 'package:app/common/roshata/rosheta_screen.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/roshata/medicalTest_screen.dart';
import '../../../../../common/roshata/newTestScreen.dart';
import '../../../../../common/roshata/new_rosheta_screen.dart';
import '../../../../doctor_dashboard_screen/models/user_data_model.dart';
import '../../../patients_files_search/models/patient_model.dart';
import '../../patient_file_view_model/patients_file_view_model.dart';

class MedicalTestView extends ConsumerStatefulWidget {
  Patient patient;
   MedicalTestView({Key? key,required this.patient}) : super(key: key);

  @override
  ConsumerState<MedicalTestView> createState() => _MedicalTestViewState();
}

class _MedicalTestViewState extends ConsumerState<MedicalTestView> {
  @override
  Widget build(BuildContext context) {
    widget.patient=ref.watch(fileViewModelProvider).currentPatient!;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
         // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildButton(context),
          ),
           ListView.separated(
             physics: BouncingScrollPhysics(),
             shrinkWrap: true,
             itemCount: widget.patient.medicalRecord?.medicalTests?.length??0,
               itemBuilder: (context,index){
                 widget.patient=ref.watch(fileViewModelProvider).currentPatient!;
                 return InkWell(
               /*      onLongPress: () async {
                    await ref
                        .read(fileViewModelProvider.notifier)
                        .deletePrescription(
                            widget.patient,
                            widget
                                .patient.medicalRecord!.prescriptions![index]);
                  },*/
                  child: MedicalTestScreen(patient: widget.patient,medicalTests:widget.patient.medicalRecord!.medicalTests![index]));
           }, separatorBuilder: (BuildContext context, int index) =>SizedBox(height: .5.h,) ,)
        ],
      ),
    );
  }
  Widget buildButton(context) {
    return SizedBox(
      width: 45.w,
      child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ThemeColors.kPrimary,),
          onPressed: ()async {
            FlutterSecureStorage storage = const FlutterSecureStorage();
            String? user = await storage.read(
              key: 'currentUser',
            );
            if (user == null)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(child: Text("login_alert".tr())),
              ));
            else{
              User admin = User.fromJson(json.decode(user ?? ''));
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          padding: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * .50,
                          width: MediaQuery.of(context).size.width * .95,
                          child: NewTestScreen(
                            patient: widget.patient,
                            user: admin,
                          )),
                    );
                  }).then((value) async {
                await ref
                    .read(fileViewModelProvider.notifier)
                    .fetchPatientTests(widget.patient);
              });
            }
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "patients.add_medical_test".tr(),
                style:tsS16W500CkLightBlue,
              ),
              Icon(Icons.add,color:ThemeColors.kLightBlue,),
            ],
          )
      ),
    );
  }
}


