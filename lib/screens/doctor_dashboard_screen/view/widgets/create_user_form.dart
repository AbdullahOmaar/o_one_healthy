import 'dart:convert';

import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../../../common/widget_utils.dart';
import '../../models/user_data_model.dart';
import '../../view_model/dashboard_view_model.dart';

class CreateUserForm extends ConsumerStatefulWidget {
  const CreateUserForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends ConsumerState<CreateUserForm> {
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController uidEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController countryEditingController = TextEditingController();
  TextEditingController governorateEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  late CheckboxListTile hasAdsPrivilegesCheckBox;
  late CheckboxListTile isAdminCheckBox;
  late CheckboxListTile isClinicCheckBox;
  late CheckboxListTile isDoctorCheckBox;
  late CheckboxListTile isLaboratoryCheckBox;
  late CheckboxListTile isPharmacyCheckBox;
  late double fullWidth;
  final formKey = GlobalKey<FormState>();
  final passwordGenerator = RandomPasswordGenerator();
  late DashboardViewModel viewModelReader;
  bool isUidExists=false;
  User user = User(
      name: '',
      phoneNumber: '',
      uid: '1',
      password: '',
      email: "",
      address: Address(city: 'v', country: 'c', governorate: 'g'),
      createdBy: CreatedBy(createdDate: "", creatorName: "", creatorUid: ''),
      privileges: Privileges(
        hasAdsPrivileges: false,
        isAdmin: false,
        isClinic: false,
        isDoctor: false,
        isLaboratory: false,
        isPharmacy: false,
      ));

  @override
  Widget build(BuildContext context) {
    fullWidth = MediaQuery.of(context).size.width;
    viewModelReader = ref.read(dashboardViewModelProvider.notifier);

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
              controller: usernameTextEditingController,
              inputType: TextInputType.text,
              labelText: 'Username',
              isPassword: false,
              suffix: Icons.person,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Please enter valid name';
                }
                return null;
              },
              onChanged: (val) {
                user.name = val;
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
              return  viewModelReader.validateUserID(value, isUidExists);
              },
              onChanged: (val) {
                user.uid = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: emailEditingController,
              inputType: TextInputType.number,
              labelText: 'E-mail',
              isPassword: false,
              suffix: Icons.email,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Enter valid email';
                }
                return null;
              },
              onChanged: (val) {
                user.email = val;
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
                user.phoneNumber = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: countryEditingController,
              inputType: TextInputType.text,
              labelText: 'Country',
              isPassword: false,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Country can not be empty';
                }
                return null;
              },
              onChanged: (value) {
                user.address?.country = value;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: governorateEditingController,
              inputType: TextInputType.text,
              labelText: 'Governorate',
              isPassword: false,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Governorate can not be empty';
                }
                return null;
              },
              onChanged: (val) {
                user.address?.governorate = val;
              },
            ),
            getVerticalSpacerWidget(context),
            CustomTextField(
              controller: cityEditingController,
              inputType: TextInputType.text,
              labelText: 'City',
              isPassword: false,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'City can not be empty';
                }
                return null;
              },
              onChanged: (value) {
                user.address?.city = value;
              },
            ),
            getVerticalSpacerWidget(context),
            ExpansionTile(title: const Text('User privileges'), children: [
              hasAdsPrivilegesCheckBox,
              getVerticalSpacerLine(
                  fullWidth, CustomWidth.matchParent, Colors.grey.shade300, 30),
              isAdminCheckBox,
              getVerticalSpacerLine(
                  fullWidth, CustomWidth.matchParent, Colors.grey.shade300, 30),
              isClinicCheckBox,
              getVerticalSpacerLine(
                  fullWidth, CustomWidth.matchParent, Colors.grey.shade300, 30),
              isDoctorCheckBox,
              getVerticalSpacerLine(
                  fullWidth, CustomWidth.matchParent, Colors.grey.shade300, 30),
              isLaboratoryCheckBox,
              getVerticalSpacerLine(
                  fullWidth, CustomWidth.matchParent, Colors.grey.shade300, 30),
              isPharmacyCheckBox,
            ]),
            getVerticalSpacerWidget(context),
            ref.watch(dashboardViewModelProvider).isCreated
                ? CustomButton(
                    onPressed: ()async {
                       FlutterSecureStorage storage = const FlutterSecureStorage();

                      String? data = await storage.read(
                        key: 'currentUser',
                      );
                      User admin = User.fromJson(json.decode(data ?? ''));
                      isUidExists= await viewModelReader.validateUserIdExist(user.uid);
                      if (formKey.currentState!.validate()) {
                       if(isUidExists){
                         return;
                      }else {
                         user.password = viewModelReader
                              .generatePassword(); //generate random password
                         user.createdBy=CreatedBy(creatorName: admin.name, creatorUid: admin.uid, createdDate: DateTime.now().toString());
                          viewModelReader.postNewUser(user);
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
    hasAdsPrivilegesCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.hasAdsPrivileges = value!;
        });
      },
      value: user.privileges.hasAdsPrivileges,
      title: const Text('Can hire Ads ?'),
    );
    isAdminCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.isAdmin = value!;
        });
      },
      value: user.privileges.isAdmin,
      title: const Text('is admin ?'),
    );
    isClinicCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.isClinic = value!;
        });
      },
      value: user.privileges.isClinic,
      title: const Text('is clinic ?'),
    );
    isDoctorCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.isDoctor = value!;
        });
      },
      value: user.privileges.isDoctor,
      title: const Text('is doctor ?'),
    );
    isLaboratoryCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.isLaboratory = value!;
        });
      },
      value: user.privileges.isLaboratory,
      title: const Text('is laboratory ?'),
    );
    isPharmacyCheckBox = CheckboxListTile(
      onChanged: (bool? value) {
        setState(() {
          user.privileges.isPharmacy = value!;
        });
      },
      value: user.privileges.isPharmacy,
      title: const Text('is pharmacy ?'),
    );
  }
}
