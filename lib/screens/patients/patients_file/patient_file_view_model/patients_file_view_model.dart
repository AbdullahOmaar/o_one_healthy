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
  Patient? currentPatient ;
  bool? isPushLoading;
  FilesSearchState({this.currentPatient,this.isPushLoading});

  FilesSearchState copyWith({Patient? patient, bool? isPushLoading}) {
    return FilesSearchState(
      currentPatient: patient,
      isPushLoading: isPushLoading??false
    );
  }
}

class FilesViewModel extends StateNotifier<FilesSearchState> {
  final FilesRepository repo;
  final passwordGenerator =RandomPasswordGenerator();

  FilesViewModel(this.repo)
      : super(FilesSearchState(isPushLoading: false));

  pushPatientFile(File file,Patient patient ,FileType fileType) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.uploadFileToStorage(file,patient,fileType);
  }
  getPatientData(Patient patient) async {
    // Patient updatedPatient;
    /*updatedPatient=await*/ repo.getUpdatedPatientFile(patient.uid).then((value) {
      state=state.copyWith(patient: value,isPushLoading: false) ;
    }).catchError((e){
      state=state.copyWith(patient: patient,isPushLoading: false) ;
    });

  }
}
