import 'dart:io';
import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../patient_file_repository/patients_files_repository.dart';


final fileViewModelProvider =
    StateNotifierProvider<FilesViewModel, FilesSearchState>(
        (ref) =>
            FilesViewModel(ref.watch(filesRepositoryProvider)));

class FilesSearchState {
  final List<Patient> patients;
   bool? isCreated;


  FilesSearchState({required this.patients,this.isCreated});

  FilesSearchState copyWith({required List<Patient>? patient ,bool? isCreated}) {
    return FilesSearchState(
      patients: patient ?? patients,
      isCreated: isCreated ?? true
    );
  }
}

class FilesViewModel extends StateNotifier<FilesSearchState> {
  final FilesRepository repo;
  final passwordGenerator =RandomPasswordGenerator();

  FilesViewModel(this.repo)
      : super(FilesSearchState(patients: [
          Patient(
              isLocked: false,
              isPassword: false,
              nameAR: "A",
              nameEN: "A",
              uid: "11",
              patientDetails: PatientDetails(age: 10, imgUrl: "n"))
        ]));

  pushPatientFile(File file,Patient patient ,FileType fileType) async {
      await repo.uploadFileToStorage(file,patient,fileType);

  }
}
