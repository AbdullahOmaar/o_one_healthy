import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../coomon/bottom_bar_widget/bottom_bar_view.dart';
import '../../../coomon/bottombar_view_model/bottomBar_view_model.dart';
import '../../../coomon/custom_text_field/custom_text_field.dart';
import '../../../coomon/widget_utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = ref.read((bottomBarViewModelProvider)).currentIndex;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;
    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: getCurrentScreen(login),
    );
  }

  getLoginBody(login) => Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40,
              child: Image.asset(
                'assets/images/immg.png',
                fit: BoxFit.fill,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .65 -
                    kBottomNavigationBarHeight,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                      getVerticalSpacerWidget(context),
                      CustomTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.text,
                        labelText: 'user name',
                        // prefix: Icons.remove_red_eye,
                        suffix: Icons.person,
                        isPassword: false,
                      ),
                      getVerticalSpacerWidget(context),
                      CustomTextField(
                        controller: TextEditingController(),
                        inputType: TextInputType.text,
                        labelText: 'password',
                        // prefix: Icons.remove_red_eye,
                        suffix: Icons.remove_red_eye,
                        isPassword: false,
                      ),
                      getVerticalSpacerWidget(context),
                      Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.indigo,
                              ),
                            )),
                      ),
                      getVerticalSpacerWidget(context),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: FilledButton(
                              style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                            onPressed: () {},
                            child: const Text('Login now',style: TextStyle(fontSize: 16),),
                          ),
                          ))
                    ],
                  ),
                )),
          )
        ],
      );

  getCurrentScreen(login) {
    if (ref.watch(bottomBarViewModelProvider).selectedScreen ==
        SelectedScreen.login) {
      return getLoginBody(login);
    } else {
      return ref
          .watch(bottomBarViewModelProvider.notifier)
          .screens[ref.watch(bottomBarViewModelProvider).currentIndex];
    }
  }
}
