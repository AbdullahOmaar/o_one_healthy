
import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../../../common/widget_utils.dart';
import '../../../doctor_dashboard_screen/view_model/dashboard_view_model.dart';
import '../../models/subscribe_request.dart';


class CreateSubscribeRequestForm extends ConsumerStatefulWidget {
  const CreateSubscribeRequestForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateSubscribeRequestFormState();
}

class _CreateSubscribeRequestFormState extends ConsumerState<CreateSubscribeRequestForm> {
  TextEditingController usernameTextEditingController = TextEditingController();

  TextEditingController phoneNumberEditingController = TextEditingController();

  late double fullWidth;
  final formKey = GlobalKey<FormState>();
  final passwordGenerator = RandomPasswordGenerator();
  late DashboardViewModel viewModelReader;
  // bool isUidExists=false;
  SubscribeRequest subscribeRequest = SubscribeRequest(name: '', phoneNumber: '');

  @override
  Widget build(BuildContext context) {
    fullWidth = MediaQuery.of(context).size.width;
     viewModelReader = ref.read(dashboardViewModelProvider.notifier);
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
                subscribeRequest.name = val;
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
                subscribeRequest.phoneNumber = val;
              },
            ),
            getVerticalSpacerWidget(context),
            ref.watch(dashboardViewModelProvider).isNotCreated
                ? CustomButton(
              onPressed: ()async {
                if (formKey.currentState!.validate()) {
                  viewModelReader.postSubscriptionRequest(subscribeRequest);
                  Navigator.of(context).pop();
                }
              },
              text: 'Submit',
              fontSize: 20,
              btnWidth: CustomWidth.half,
            ): const CircularProgressIndicator(),
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
}
