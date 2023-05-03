
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginViwState>(
    (ref) => LoginViewModel(ref.watch(loginRepositoryProvider))
);

class LoginViwState{
  final LoginModel? loginModel;

  LoginViwState({this.loginModel});

  LoginViwState copyWith({
    LoginModel? loginModel
}){
    return LoginViwState(
      loginModel: loginModel ?? this.loginModel,
    );
  }
}


class LoginViewModel extends StateNotifier<LoginViwState> {
  final LoginRepository repo;

  LoginViewModel(this.repo): super(LoginViwState(loginModel: LoginModel(name: "skajdhksajhdjkashdkjashdjk")));

  getLoginLogo(url) async{
    final resModel = await repo.getLoginServices(url);

    state =state.copyWith(
      loginModel: resModel,
    );
  }
}