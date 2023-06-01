import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../models/patient_model.dart';

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
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.patient.patientDetails?.imgUrl == null
                          ? Image.asset('assets/images/logo/logo.jpeg').image
                          : NetworkImage(widget.patient.patientDetails?.imgUrl ?? ''),
                    ),
                    getPatientNameText(widget.patient.nameEN)
                  ],
                ),
                if (widget.patient.isPassword)
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CustomTextField(
                          controller: patientFilePasswordTEC,
                          inputType: TextInputType.text,
                          labelText: 'Enter your file password',
                          isPassword: true,
                        ),
                      ),
                      CustomButton(
                          fontSize: 10,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.patientFileScreen,
                              arguments: widget.patient
                            );

                            ///TODO handle password Validation
                          },
                          text: 'Enter',
                          btnWidth: CustomWidth.oneThird),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPatientNameText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
}
