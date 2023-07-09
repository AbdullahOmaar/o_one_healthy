import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/bottom_bar/bottombar_view_model/bottomBar_view_model.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/common/logo.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/screens/doctor_dashboard_screen/view/dashboard_screen.dart';
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../common/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/LoginScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  int? currentIndex;
 late LoginViewModel loginViewModel;
 late LoginViwState stateWatcher ;

  TextEditingController uidTextEditingController =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isAuth =false;

  @override
  void initState() {
    super.initState();
    currentIndex = ref.read((bottomBarViewModelProvider)).currentIndex;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    loginViewModel=ref.read(loginViewModelProvider.notifier);
    stateWatcher =ref.read(loginViewModelProvider);

    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: getLoginBody(),
    );
  }

  getLoginBody() => Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: appLogo()),
                getVerticalSpacerWidget(context),
                const Text("ID",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 8.0,
                ),
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
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 12.0,
                ),
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
                      activeColor: ThemeColors.primay,
                      checkColor: Colors.white,
                    )
                  ],
                ),
                GestureDetector(
                  child: Text("Forget Password?", style: tsS14W500CkPrimary),
                  onTap: () {},
                ),
                getVerticalSpacerWidget(context),
                solidButton(
                  backgroundColor: ThemeColors.primay,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      RouteGenerator.generateRoute(
                          const RouteSettings(name: AppRoutes.doctorDashboard)),
                      (route) => false,
                    );
                  },
                  text: "Login",
                  image: "assets/images/icon/login.png",
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
        ),
      )
      //  Stack(
      //       children: [
      //         SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             height: MediaQuery.of(context).size.height * 0.35,
      //             child: Image.asset(
      //               'assets/images/immg.png',
      //               fit: BoxFit.fill,
      //             )),
      //         Align(
      //           alignment: Alignment.bottomCenter,
      //           child: Container(
      //               decoration: const BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(25),
      //                     topRight: Radius.circular(25),
      //                   )),
      //               width: MediaQuery.of(context).size.width,
      //               height: MediaQuery.of(context).size.height * .65 -
      //                   kBottomNavigationBarHeight,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(25.0),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     const Text(
      //                       'Login',
      //                       style: TextStyle(
      //                           fontSize: 36.0,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.indigo),
      //                     ),
      //                     getVerticalSpacerWidget(context),
      //                     Flexible(
      // /                    child: CustomTextField
      //                         controller: uidTextEditingController,
      //                         inputType: TextInputType.text,
      //                         labelText: 'Enter your ID',
      //                         // prefix: Icons.remove_red_eye,
      //                         suffix: Icons.person,
      //                         isPassword: false,
      //                         validate: (String value){
      //                           if(value.isEmpty) {
      //                             return 'ID must not be empty';
      //                           }else if (!isAuth) {
      //                             return 'wrong ID or password';
      //                           }
      //                           return null;
      //                         },
      //                       ),
      //                     ),
      //                     getVerticalSpacerWidget(context),
      //                     Flexible(
      // child: CustomTextField
      //                         controller: passwordTextEditingController,
      //                         inputType: TextInputType.text,
      //                         labelText: 'password',
      //                         // prefix: Icons.remove_red_eye,
      //                         suffix: Icons.remove_red_eye,
      //                         isPassword: false,
      //                         validate: (String value){
      //                           if(value.isEmpty) {
      //                             return 'Password must not be empty';
      //                           }else if (!isAuth) {
      //                             return 'wrong ID or password';
      //                           }
      //                           return null;
      //                         },
      //                       ),
      //                     ),
      //                     getVerticalSpacerWidget(context),
      //                     Center(
      //                       child: TextButton(
      //                           onPressed: () {},
      //                           child: const Text(
      //                             'Forget password?',
      //                             style: TextStyle(
      //                               fontSize: 14,
      //                               color: Colors.indigo,
      //                             ),
      //                           )),
      //                     ),
      //                     getVerticalSpacerWidget(context),
      //                     Align(
      //                         alignment: Alignment.bottomCenter,
      //                         child: SizedBox(
      //                           width: MediaQuery.of(context).size.width * 0.5,
      //                           child: stateWatcher.isLoading?const Center(child: CircularProgressIndicator()):CustomButton(
      //                             btnWidth: CustomWidth.half,
      //                             fontSize: 16,
      //                             onPressed: () async{
      //                               final String uid= uidTextEditingController.text;
      //                               isAuth =await loginViewModel.authUser(uid, passwordTextEditingController.text);
      //                               if (formKey.currentState!.validate()) {
      //                                 if(!isAuth){
      //                                   return;
      //                                 }else {
      //                               await loginViewModel.getUserData(uid).then((_){
      //                                    Navigator.of(context).pushAndRemoveUntil( RouteGenerator.generateRoute(
      //                                   const RouteSettings(
      //                                       name: AppRoutes.doctorDashboard)),(route) => false,);
      //                               });
      //                                 }
      //                               }

      //                             },
      //                             text: "Login now",
      //                           ),
      //                         ))
      //                   ],
      //                 ),
      //               )),
      //         )
      //       ],
      //     ),
      );

  getCurrentScreen(login) {
    if (ref.watch(bottomBarViewModelProvider).selectedScreen ==
        SelectedScreen.login) {
      return getLoginBody();
    } else {
      return ref
          .watch(bottomBarViewModelProvider.notifier)
          .screens[ref.watch(bottomBarViewModelProvider).currentIndex];
    }
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
