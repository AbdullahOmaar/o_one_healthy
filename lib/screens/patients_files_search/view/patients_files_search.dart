import 'package:flutter/material.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text_field/custom_text_field.dart';
import '../models/patient_model.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  TextEditingController patientFilePasswordTEC = TextEditingController();

  PatientCard({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(

        width: MediaQuery.of(context).size.width*0.95,
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

                      backgroundImage: patient.patientDetails?.imgUrl == null
                          ? Image.asset('assets/images/logo/logo.jpeg').image
                          : NetworkImage(patient.patientDetails?.imgUrl ?? ''),
                    ),
                    getPatientNameText(patient.nameEN)
                  ],
                ),
                if (patient.isPassword)
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
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
