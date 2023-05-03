
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/view/widgets/logo.dart';
import 'package:app/screens/login/view_model/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    LoginModel? login = ref.watch((loginViewModelProvider)).loginModel;

    return Column(

      children:  [
        GetLogoWidget(login: login),
        const GetLogoWidget(),
        const GetLogoWidget()
      ],
    );
  }
}
