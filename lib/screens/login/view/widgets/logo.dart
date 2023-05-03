import 'package:app/screens/login/model/login_model.dart';
import 'package:flutter/cupertino.dart';

class GetLogoWidget extends StatelessWidget {
   const GetLogoWidget({Key? key, this.login}) : super(key: key);
    final LoginModel? login;

  @override
  Widget build(BuildContext context) {
    return  Text("${login?.name}");
  }
}
