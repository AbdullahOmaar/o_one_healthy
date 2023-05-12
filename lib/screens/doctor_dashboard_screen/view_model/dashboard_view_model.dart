import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_data_model.dart';
import '../repository/doctor_dashboard_repository.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) =>
        DashboardViewModel(ref.watch(doctorDashboardRepositoryProvider)));

class DashboardState {
  final bool isCreated;

  DashboardState({required this.isCreated});

  DashboardState copyWith({required bool isCreated}) {
    return DashboardState(
      isCreated: isCreated,
    );
  }
}

class DashboardViewModel extends StateNotifier<DashboardState> {
  final DoctorDashboardRepo repo;

  DashboardViewModel(this.repo) : super(DashboardState(isCreated: true));

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
}
