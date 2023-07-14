import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/common/logo.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/LoginScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late LoginViewModel loginViewModel;
  late LoginViwState stateWatcher;

  TextEditingController uidTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    loginViewModel = ref.read(loginViewModelProvider.notifier);
    stateWatcher = ref.read(loginViewModelProvider);

    return BaseScaffold(
      // appBar: baseAppBar(context, "tittle"),
      body: body(),
    );
  }

  body() => Center(
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appLogo(),
                  Dimens.vMargin8,
                  Text("login.id".tr(), style: tsS12W500CkBlack),
                  // Dimens.hMargin2,
                  CustomTextField(
                    controller: uidTextEditingController,
                    inputType: TextInputType.number,
                    labelText: "login.id".tr(),
                    validate: handelValidator,
                  ),
                  Dimens.vMargin5,
                  Text("login.password".tr(), style: tsS12W500CkBlack),
                  // Dimens.vMargin2,
                  CustomTextField(
                    controller: passwordTextEditingController,
                    inputType: TextInputType.text,
                    labelText: "login.password".tr(),
                    validate: handelValidator,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          onChanged: (value) {},
                          value: true,
                          activeColor: ThemeColors.primary,
                          checkColor: Colors.white,
                        ),
                      ),
                      Dimens.hMargin2,
                      Text("login.remember_me".tr(), style: tsS12W500CkBlack)
                    ],
                  ),
                  // GestureDetector(
                  //   child: Text("Forget Password?", style: tsS16W500CkPrimary),
                  //   onTap: () {},
                  // ),
                  Dimens.vMargin5,
                  stateWatcher.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : solidButton(
                          onPressed: () async {
                            {
                              final String uid = uidTextEditingController.text;
                              isAuth = await loginViewModel.authUser(
                                  uid, passwordTextEditingController.text);
                              if (formKey.currentState!.validate()) {
                                if (!isAuth) {
                                  return;
                                } else {
                                  await loginViewModel.getUserData(uid).then(
                                    (_) {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.doctorDashboard);
                                    },
                                  );
                                }
                              }
                            }
                          },
                          text: "login.login".tr(),
                          image: "assets/images/icon/login.png",
                        ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("login.don't_have_account".tr(),
                            style: tsS12W500CkBlack),
                        GestureDetector(
                          child: Text("login.add_account".tr(),
                              style: tsS12W500CkPrimary),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );

  handelValidator(value) {
    if (value!.isEmpty) {
      return 'Password must not be empty';
    } else if (!isAuth) {
      return 'wrong ID or password';
    }
    return null;
  }

  addFirData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }
}
