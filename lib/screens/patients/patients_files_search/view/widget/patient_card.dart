import 'package:app/routes/app_routes.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PatientCard extends StatefulWidget {
  Patient patient;

  PatientCard({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  TextEditingController patientFilePasswordTEC = TextEditingController();

  @override
  void didUpdateWidget(PatientCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.patientFileScreen,
            arguments: widget.patient);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          width: double.infinity,
          height: 10.h,
          decoration: BoxDecoration(
            color: ThemeColors.primary,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.more_vert, size: 30.0),
                  onPressed: () {},
                ),
                Dimens.hMargin12,
                getPatientNameText(widget.patient.nameEN),
                Image.asset(
                  Images.files,
                  fit: BoxFit.contain,
                  width: 50.0,
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
      // child: SizedBox(
      //   width: MediaQuery.of(context).size.width * 0.95,
      //   child: Card(
      //     elevation: 3,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               CircleAvatar(
      //                 radius: 20,
      //                 backgroundImage: widget.patient.patientDetails?.imgUrl ==
      //                         null
      //                     ? Image.asset('assets/images/logo/logo.jpeg').image
      //                     : NetworkImage(
      //                         widget.patient.patientDetails?.imgUrl ?? ''),
      //               ),
      //               getPatientNameText(widget.patient.nameEN)
      //             ],
      //           ),
      //           if (widget.patient.isPassword)
      //             Column(
      //               children: [
      //                 SizedBox(
      //                   width: MediaQuery.of(context).size.width * 0.8,
      //                   child: CustomTextField(
      //                     controller: patientFilePasswordTEC,
      //                     inputType: TextInputType.text,
      //                     labelText: 'Enter your file password',
      //                     isPassword: true,
      //                   ),
      //                 ),
      //                 CustomButton(
      //                     fontSize: 10,
      //                     onPressed: () {
      //                       Navigator.pushNamed(
      //                           context, AppRoutes.patientFileScreen,
      //                           arguments: widget.patient);

      //                       ///TODO handle password Validation
      //                     },
      //                     text: 'Enter',
      //                     btnWidth: CustomWidth.oneThird),
      //               ],
      //             )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget getPatientNameText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
}
