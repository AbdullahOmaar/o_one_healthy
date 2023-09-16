import 'dart:io';
import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:firebase_database/firebase_database.dart';
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

  pushPatientFile(File file,Patient patient ,CustomFileType fileType) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.uploadFileToStorage(file,patient,fileType);
  }
  pushMedicalTestFile(File file, Patient patient, CustomFileType fileType,TestData testData,String testID) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.uploadMedicalTestFileToStorage(file,patient,fileType,testData,testID);
  }
  postPatientTests(Patient patient ,MedicalTests medicalTest) async {
    state = state.copyWith(patient: patient, isPushLoading: true);
    await repo.postPatientTests(patient, medicalTest);
  }
  postMedicalTestData(Patient patient ,TestData testData,String testID) async {
    state = state.copyWith(patient: patient, isPushLoading: true);
    await repo.postMedicalTestData(patient, testData,testID).then((value) {
      fetchPatientTests(patient);
    });
  }
  fetchPatientTests(Patient patient)async{
    await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord').onValue.listen((event) {

      var snapshot = event.snapshot;
      patient.medicalRecord?.medicalTests=  getMedicalTestList(Map<String,dynamic>.from(snapshot.value as Map) ['medicalTests'] );
      state=state.copyWith(patient: patient,isPushLoading: false);
      // map=Map<String,dynamic>.from(snapshot.value as Map);
    });
    patient.medicalRecord?.medicalTests= await repo.getPatientTests(patient);
    state=state.copyWith(patient: patient,isPushLoading: false);
  }
  pushPatientPrescription(Patient patient ,Prescription prescription) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.postPatientPrescription(patient,prescription);
  }
  updateMedicine(Patient patient ,Prescription prescription,Medicine medicine,bool isNewPrescription) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.updateMedicine(patient,prescription,medicine,isNewPrescription).then((value) {
        fetchPatientPrescriptions(patient);
      });
  }
  deleteMedicine(Patient patient ,Prescription prescription,String medicineIndex) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.deleteMedicine(patient,prescription,medicineIndex).then((value) {
        fetchPatientPrescriptions(patient);
      });
  }
  deletePrescription(Patient patient ,Prescription prescription) async {
    state=state.copyWith(patient: patient,isPushLoading: true);
      await repo.deletePrescription(patient,prescription).then((value) {
        fetchPatientPrescriptions(patient);
      });
  }
  fetchPatientPrescriptions(Patient patient)async{
    patient.medicalRecord?.prescriptions= await repo.getPatientPrescription(patient);
    state=state.copyWith(patient: patient,isPushLoading: false);
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
