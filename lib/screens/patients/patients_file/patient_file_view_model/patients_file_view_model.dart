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

  FilesSearchState({this.currentPatient});

  FilesSearchState copyWith({Patient? patient}) {
    return FilesSearchState(
      currentPatient: patient
    );
  }
}

class FilesViewModel extends StateNotifier<FilesSearchState> {
  final FilesRepository repo;
  final passwordGenerator =RandomPasswordGenerator();

  FilesViewModel(this.repo)
      : super(FilesSearchState());

  pushPatientFile(File file,Patient patient ,FileType fileType) async {
    Patient updatedPatient;
      await repo.uploadFileToStorage(file,patient,fileType).then((value) async{
          updatedPatient=await repo.getUpdatedPatientFile(patient.uid);
          state=state.copyWith(patient: updatedPatient);
      });


  }
}
