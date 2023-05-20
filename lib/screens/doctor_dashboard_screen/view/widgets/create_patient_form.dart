import 'dart:convert';

import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../../../common/widget_utils.dart';
import '../../../patients/patients_files_search/models/patient_model.dart';
import '../../../patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import '../../models/user_data_model.dart';
import '../../view_model/dashboard_view_model.dart';

class CreatePatientForm extends ConsumerStatefulWidget {
  const CreatePatientForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePatientFormState();
}

class _CreatePatientFormState extends ConsumerState<CreatePatientForm> {
  TextEditingController usernameARTextEditingController = TextEditingController();
  TextEditingController uidEditingController = TextEditingController();
  TextEditingController usernameEnEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();
  late CheckboxListTile isPasswordCheckBox;
  late double fullWidth;
  final formKey = GlobalKey<FormState>();
  final passwordGenerator = RandomPasswordGenerator();
  late PatientSearchViewModel viewModelReader;
  bool isUidExists=false;
  Patient patient = Patient(
      phoneNumber: '',
      uid: '1',
      password: '', nameAR: '',nameEN: '', isPassword: false,patientDetails: PatientDetails(age: 0,imgUrl: ""));

  @override
  Widget build(BuildContext context) {
    fullWidth = MediaQuery.of(context).size.width;
    viewModelReader = ref.read(patientFSViewModelProvider.notifier);

    initCheckBoxes();
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),

          // mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: usernameEnEditingController,
              inputType: TextInputType.text,
              labelText: 'Username EN',
              isPassword: false,
              suffix: Icons.person,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Enter valid name';
                }
                return null;
              },
              onChanged: (val) {
                patient.nameEN = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: usernameARTextEditingController,
              inputType: TextInputType.text,
              labelText: 'Username AR',
              isPassword: false,
              suffix: Icons.person,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Please enter valid name';
                }
                return null;
              },
              onChanged: (val) {
                patient.nameAR = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: uidEditingController,
              inputType: TextInputType.number,
              labelText: 'National ID',
              isPassword: false,
              suffix: Icons.person_pin,
              validate: (String value)  {
              return  viewModelReader.validatePatientID(value, isUidExists);
              },
              onChanged: (val) {
                patient.uid = val;
              },
            ),
            getVerticalSpacerWidget(context),

            CustomTextField(
              controller: phoneNumberEditingController,
              inputType: TextInputType.phone,
              labelText: 'Phone number',
              isPassword: false,
              suffix: Icons.phone_android,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
              onChanged: (val) {
                patient.phoneNumber = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: ageEditingController,
              inputType: TextInputType.number,
              labelText: 'Age',
              isPassword: false,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Age can not be empty';
                }
                return null;
              },
              onChanged: (value) {
                patient.patientDetails?.age = int.parse(value);
              },
            ),
            getVerticalSpacerWidget(context),
            isPasswordCheckBox,
            getVerticalSpacerWidget(context),
            ref.watch(dashboardViewModelProvider).isNotCreated
                ? CustomButton(
                    onPressed: ()async {
                       FlutterSecureStorage storage = const FlutterSecureStorage();
                      String? data = await storage.read(
                        key: 'currentUser',
                      );
                      User admin = User.fromJson(json.decode(data ?? ''));
                      isUidExists= await viewModelReader.validateUserIdExist(patient.uid);
                      if (formKey.currentState!.validate()) {
                       if(isUidExists){
                         return;
                      }else {
                         if(patient.isPassword) {
                            patient.password =
                                viewModelReader.generatePassword();
                          } //generate random password
                         patient.createdBy=CreatedBy(creatorName: admin.name, creatorUid: admin.uid, createdDate: DateTime.now().toString());
                          viewModelReader.postNewPatient(patient);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    text: 'Submit',
                    fontSize: 20,
                    btnWidth: CustomWidth.half,
                  )
                : const CircularProgressIndicator(),
            getVerticalSpacerWidget(context),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cancel',
              fontSize: 20,
              btnWidth: CustomWidth.half,
            ),
          ],
        ),
      ),
    );
  }

  void initCheckBoxes() {
    isPasswordCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          patient.isPassword = value!;
        });
      },
      value: patient.isPassword,
      title: const Text('is password ?'),
    );
  }
}
