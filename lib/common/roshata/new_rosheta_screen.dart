import 'dart:convert';

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

class NewRoshetaScreen extends ConsumerStatefulWidget {
  Patient patient;

   NewRoshetaScreen({Key? key,required this.patient}) : super(key: key);

  @override
  ConsumerState<NewRoshetaScreen> createState() => _NewRoshetaScreenState();
}

class _NewRoshetaScreenState extends ConsumerState<NewRoshetaScreen> {
  final Map<String, bool> _map = {};
  Prescription prescription =Prescription();
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
              child: BuildMedicinesList(isNewPrescription:true,prescription: prescription,patient:widget.patient,onMedicineUpdate: (List<Medicine> medicines){
                setState(() {
                  prescription.medicines=medicines;
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
            User admin = User.fromJson(json.decode(data ?? ''));
            if(data==null)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Please Login first') ,));
            prescription.creator=admin;
            prescription.creationDate=DateTime.now().toString();
            await ref
                .read(fileViewModelProvider.notifier).pushPatientPrescription( widget.patient, prescription);
            Navigator.of(context).pop();
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
          Text("${"doctor".tr()}"": محمد أحمد",style: tsS12W500CkBlack,),
          Text("${"specialization".tr()}"": باطنه",style: tsS12W500CkBlack,),
        ],
      ),
     
    ],
  );
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
