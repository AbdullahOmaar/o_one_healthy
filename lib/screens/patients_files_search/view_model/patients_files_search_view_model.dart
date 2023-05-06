import 'package:app/screens/patients_files_search/models/patient_details_model.dart';
import 'package:app/screens/patients_files_search/models/patient_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/patients_files_search_repository.dart';

final patientFSViewModelProvider =
    StateNotifierProvider<PatientSearchViewModel, PatientFilesSearchState>(
        (ref) =>
            PatientSearchViewModel(ref.watch(patientsFilesRepositoryProvider)));

class PatientFilesSearchState {
  final List<Patient> patients;

  PatientFilesSearchState({required this.patients});

  PatientFilesSearchState copyWith({required List<Patient>? patient}) {
    return PatientFilesSearchState(
      patients: patient ?? patients,
    );
  }
}

class PatientSearchViewModel extends StateNotifier<PatientFilesSearchState> {
  final PatientsFilesRepository repo;

  PatientSearchViewModel(this.repo)
      : super(PatientFilesSearchState(patients: [
          Patient(
              isLocked: false,
              isPassword: false,
              nameAR: "A",
              nameEN: "A",
              uid: "11",
              patientDetails: PatientDetails(age: 10, imgUrl: "n"))
        ]));

  getPatientList() async {
    final List <Patient> resModel = await repo.getPatientsFilesSearchServices();

    state = state.copyWith(
      patient: resModel,
    );
  }
}
