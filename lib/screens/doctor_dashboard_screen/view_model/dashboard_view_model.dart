import 'package:app/screens/subscribers_screen/models/subscribe_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';
import '../models/user_data_model.dart';
import '../repository/doctor_dashboard_repository.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) =>
        DashboardViewModel(ref.watch(doctorDashboardRepositoryProvider)));

class DashboardState {
  final bool isNotCreated;
  List<User> users=[] ;
  DashboardState({required this.isNotCreated,this.users=const[]});

  DashboardState copyWith({required bool isCreated,List<User>? users}) {
    return DashboardState(
      isNotCreated: isCreated,
      users: users??[]
    );
  }
}

class DashboardViewModel extends StateNotifier<DashboardState> {
  final DoctorDashboardRepo repo;
  final passwordGenerator =RandomPasswordGenerator();

  DashboardViewModel(this.repo) : super(DashboardState(isNotCreated: true));

  String generatePassword(){
    return passwordGenerator.randomPassword(
        letters: true,
        numbers: true,
        passwordLength: 6,
        specialChar: false,
        uppercase: false);
  }
  Future<bool> validateUserIdExist(String uid)async{
    bool isExist = await repo.checkUserExisting(uid);
    return isExist;
  }
  postNewUser(User user) async {
    state = state.copyWith(
      isCreated: false,
    );
    await repo.createUser(user).then((_) {
      state = state.copyWith(
        isCreated: true,
      );
    }).catchError((e) {
      state = state.copyWith(
        isCreated: false,
      );
    });
  }
  postSubscriptionRequest(SubscribeRequest request) async {
    state = state.copyWith(
      isCreated: false,
    );
    await repo.createSubscriptionRequest(request).then((_) {
      state = state.copyWith(
        isCreated: true,
      );
    }).catchError((e) {
      state = state.copyWith(
        isCreated: false,
      );
    });
  }
  getUsersList() async {
    final List<User> users = await repo.getAllUsersFiles();
    state = state.copyWith(isCreated: true,
      users: users);
  }

  String? validateUserID(String value ,bool isUidExists)  {
  if (value.isEmpty) {
  return 'Please enter valid ID';
  } else if (value.length < 14) {
  return 'ID is less than 14';
  } else if (value.length > 14) {
  return 'ID is greater than 14';
  }else if (isUidExists) {
  return 'user id is already exists';
  }
  return null;
  }

}
