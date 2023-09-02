import 'package:app/common/roshata/widget/buld_medicines_list.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/patients/patients_files_search/models/patient_model.dart';

class RoshetaScreen extends StatefulWidget {
  Patient patient;
  Prescription prescription;
   RoshetaScreen({Key? key,required this.patient,required this.prescription}) : super(key: key);

  @override
  State<RoshetaScreen> createState() => _RoshetaScreenState();
}

class _RoshetaScreenState extends State<RoshetaScreen> {
  final Map<String, bool> _map = {};
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeColors.roshetaBG,
        border: Border.all(width: 2, color:ThemeColors.kPrimary),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          buildDoctorHeaderDetails(), 
           SizedBox(height: 30.h,
           child: Card(
            margin: EdgeInsets.all(8.0),
            child: BuildMedicinesList(prescription: widget.prescription,),
            color:Colors.white,
            shadowColor:Colors.grey.shade200,
            elevation: 1.0,
            shape:RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
            )),
          buildDoctorFooterDetails()
        ],
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
            Text("${"doctor".tr()}"": ${widget.prescription.creator?.name??''}",style: tsS12W500CkBlack,),
            Text("${"specialization".tr()}"":",style: tsS12W500CkBlack,),
          ],
        ),

      ],
    );
  }

  Widget buildDoctorFooterDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text("${"phone".tr()}"":${widget.prescription.creator?.phoneNumber??''}",style: tsS12W500CkBlack,),
        Text("${"adress".tr()}"":${widget.prescription.creator?.address?.city}-${widget.prescription.creator?.address?.governorate}-${widget.prescription.creator?.address?.country}",style: tsS12W500CkBlack,),
      ],
    );
  }
}



