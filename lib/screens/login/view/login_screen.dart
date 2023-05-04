
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view/widgets/logo.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../coomon/bottom_bar_widget/bottom_bar_view.dart';
import '../../../coomon/bottombar_view_model/bottomBar_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
int? currentIndex ;
  @override
  void initState() {
    super.initState();
     currentIndex=ref.read((bottomBarViewModelProvider)).currentIndex;

  }
  @override
  Widget build(BuildContext context,) {

    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;
    return Scaffold(
      bottomNavigationBar:const CustomBottomBarWidget(),
      body:getCurrentScreen(login),
    );
  }
  getLoginBody(login)=>Column(

    children:  [
      GetLogoWidget(login: login),
      const GetLogoWidget(),
      const GetLogoWidget()
    ],
  );
getCurrentScreen(login){
  if(ref.watch(bottomBarViewModelProvider).selectedScreen ==SelectedScreen.login) {
    return getLoginBody(login);
  } else {
    return    ref.watch(bottomBarViewModelProvider.notifier).screens[ref.watch(bottomBarViewModelProvider).currentIndex];
  }
}

}
