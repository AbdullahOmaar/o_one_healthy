import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/screens/patients/patients_files_search/repository/patients_files_search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';

final patientFSViewModelProvider =
    StateNotifierProvider<PatientSearchViewModel, PatientFilesSearchState>(
        (ref) =>
            PatientSearchViewModel(ref.watch(patientsFilesRepositoryProvider)));

class PatientFilesSearchState {
  final List<Patient> patients;
  bool? isCreated;

  PatientFilesSearchState({required this.patients, this.isCreated});

  PatientFilesSearchState copyWith(
      {required List<Patient>? patient, bool? isCreated}) {
    return PatientFilesSearchState(
        patients: patient ?? patients, isCreated: isCreated ?? true);
  }
}

class PatientSearchViewModel extends StateNotifier<PatientFilesSearchState> {
  final PatientsFilesRepository repo;
  final passwordGenerator = RandomPasswordGenerator();

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
  String generatePassword() {
    return passwordGenerator.randomPassword(
        letters: true,
        numbers: true,
        passwordLength: 6,
        specialChar: false,
        uppercase: false);
  }

  getPatientList() async {
    final List<Patient> resModel = await repo.getPatientsFilesSearchServices();

    state = state.copyWith(
      patient: resModel,
    );
  }

  Future<bool> validateUserIdExist(String uid) async {
    bool isExist = await repo.checkPatientExisting(uid);
    return isExist;
  }

  postNewPatient(Patient user) async {
    state = state.copyWith(
      isCreated: false,
      patient: [],
    );
    await repo.createPatient(user).then((_) {
      state = state.copyWith(isCreated: true, patient: []);
    }).catchError((e) {
      state = state.copyWith(isCreated: false, patient: []);
    });
  }

  String? validatePatientID(String value, bool isUidExists) {
    if (value.isEmpty) {
      return 'Please enter valid ID';
    } else if (value.length < 14) {
      return 'ID is less than 14';
    } else if (value.length > 14) {
      return 'ID is greater than 14';
    } else if (isUidExists) {
      return 'user id is already exists';
    }
    return null;
  }
}
