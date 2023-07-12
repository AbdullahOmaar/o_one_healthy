import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/bottom_bar/bottombar_view_model/bottomBar_view_model.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/common/logo.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/routes/route_generator.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
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

    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;
    return BaseScaffold(
      // appBar: baseAppBar(),
      body: body(),
    );
  }

  body() => Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appLogo(),
              Dimens.vMargin5,
              CustomTextField(
                  controller: uidTextEditingController,
                  inputType: TextInputType.number,
                  labelText: 'ID'),
              const Text("ID",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400)),
              // Dimens.vMargin5,
              TextFormField(
                  controller: uidTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'ID',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.9, style: BorderStyle.solid),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'ID must not be empty';
                    } else if (!isAuth) {
                      return 'wrong ID or password';
                    }
                    return null;
                  }),
              Dimens.vMargin5,
              const Text("Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            // color: Colors.red,
                            width: 0.9,
                            style: BorderStyle.solid),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    } else if (!isAuth) {
                      return 'wrong ID or password';
                    }
                    return null;
                  }),
              Row(
                children: [
                  Text("Remember Me", style: tsS14W500CkPrimary),
                  Checkbox(
                    onChanged: (value) {},
                    value: true,
                    // fillColor:  ThemeColors.primay,
                    activeColor: ThemeColors.primary,
                    checkColor: Colors.white,
                  )
                ],
              ),
              GestureDetector(
                child: Text("Forget Password?", style: tsS14W500CkPrimary),
                onTap: () {},
              ),
              getVerticalSpacerWidget(context),
              stateWatcher.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size.fromHeight(58),
                      ),
                      onPressed: () async {
                        final String uid = uidTextEditingController.text;
                        isAuth = await loginViewModel.authUser(
                            uid, passwordTextEditingController.text);
                        if (formKey.currentState!.validate()) {
                          if (!isAuth) {
                            return;
                          } else {
                            await loginViewModel.getUserData(uid).then(
                              (_) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  RouteGenerator.generateRoute(
                                      const RouteSettings(
                                          name: AppRoutes.doctorDashboard)),
                                  (route) => false,
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icon/login.png",
                            width: 20.0,
                            height: 20.0,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Login",
                            style: tsS14W700Ckblack,
                          )
                        ],
                      ),
                    ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                child: Text("Don't Have Account", style: tsS14W500CkPrimary),
                onTap: () {},
              ),
            ],
          ),
        ),
      ));

  addFirData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }
}
