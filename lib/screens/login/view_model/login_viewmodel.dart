import 'dart:convert';

import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../doctor_dashboard_screen/models/user_data_model.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginViwState>(
        (ref) => LoginViewModel(ref.watch(loginRepositoryProvider)));

class LoginViwState {
  final LoginModel? loginModel;
  bool isLoading = false;

  LoginViwState({this.loginModel, required this.isLoading});

  LoginViwState copyWith({LoginModel? loginModel, bool? isLoading}) {
    return LoginViwState(
      loginModel: loginModel ?? this.loginModel,
      isLoading: isLoading ?? false,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginViwState> {
  final LoginRepository repo;

  LoginViewModel(this.repo)
      : super(LoginViwState(
            loginModel: LoginModel(name: "skajdhksajhdjkashdkjashdjk"),
            isLoading: false));

  getLoginLogo(url) async {
    final resModel = await repo.getLoginServices(url);

    state = state.copyWith(
      loginModel: resModel,
    );
  }

  Future<bool> authUser(String uid, String password) async {
    bool isUserExists = await repo.checkUserExistence(uid, password);
    return isUserExists;
  }

  Future<void> getUserData(String uid) async {
    state = state.copyWith(loginModel: null, isLoading: true);
    try {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      User user = await repo.getUserData(uid);
      await storage.write(
          key: 'currentUser', value: json.encode(user.toJson()));
      RandomPasswordGenerator().randomPassword(
          letters: true,
          numbers: true,
          passwordLength: 20,
          specialChar: false,
          uppercase: false);
      await storage.write(
          key: 'userSession',
          value: RandomPasswordGenerator().randomPassword(
              letters: true,
              numbers: true,
              passwordLength: 20,
              specialChar: false,
              uppercase: true));
      state = state.copyWith(loginModel: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(loginModel: null, isLoading: false);
    }
  }
}
