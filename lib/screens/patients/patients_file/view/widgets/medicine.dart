import 'package:app/common/roshata/rosheta_screen.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/roshata/new_rosheta_screen.dart';
import '../../../patients_files_search/models/patient_model.dart';
import '../../patient_file_view_model/patients_file_view_model.dart';

class MedicineView extends ConsumerStatefulWidget {
  Patient patient;
   MedicineView({Key? key,required this.patient}) : super(key: key);

  @override
  ConsumerState<MedicineView> createState() => _MedicineViewState();
}

class _MedicineViewState extends ConsumerState<MedicineView> {
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
             itemCount: widget.patient.medicalRecord?.prescriptions?.length??0,
               itemBuilder: (context,index){
                 widget.patient=ref.watch(fileViewModelProvider).currentPatient!;
                 return InkWell(
                     onLongPress: () async {
                    await ref
                        .read(fileViewModelProvider.notifier)
                        .deletePrescription(
                            widget.patient,
                            widget
                                .patient.medicalRecord!.prescriptions![index]);
                  },
                  child: RoshetaScreen(patient: widget.patient,prescription:widget.patient.medicalRecord!.prescriptions![index]));
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        padding: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height*.50,
                        width:MediaQuery.of(context).size.width*.95,
                        child:NewRoshetaScreen(patient: widget.patient,)
                    ),
                  );
                }).then((value)async {
              await ref
                  .read(fileViewModelProvider.notifier).fetchPatientPrescriptions( widget.patient);
            });
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "patients.add_prescription".tr(),
                style:tsS16W500CkLightBlue,
              ),
              Icon(Icons.add,color:ThemeColors.kLightBlue,),
            ],
          )
      ),
    );
  }
}


