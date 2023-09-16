import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../patients_files_search/models/patient_model.dart';

abstract class IFilesRepository {
  Future<void> postPatientFileUrl(Patient patient, String uri, String fileType);
  Future<void> postPatientTests(Patient patient,MedicalTests medicalTests);
  Future<List<MedicalTests>> getPatientTests(Patient patient);
  Future<void> postMedicalTestData(Patient patient,TestData testData, String testID);
  Future<void> postPatientPrescription(Patient patient, Prescription prescription);
  Future<void> updateMedicine(Patient patient, Prescription prescription,Medicine medicine,bool isNewPrescription);
  Future<void> deleteMedicine(Patient patient, Prescription prescription,String medicineIndex);
  Future<void> deletePrescription(Patient patient, Prescription prescription);
  Future<List<Prescription>> getPatientPrescription(Patient patient);

  Future<void> uploadFileToStorage(
      File file, Patient patient, CustomFileType fileType);
  Future<void> uploadMedicalTestFileToStorage(
      File file, Patient patient, CustomFileType fileType,TestData testData, String testID);
  Future<Patient> getUpdatedPatientFile (String uid);
}

enum CustomFileType { pdf, dicom, image }

final filesRepositoryProvider = Provider((ref) => FilesRepository());

class FilesRepository extends IFilesRepository {


  @override
  Future<void> uploadFileToStorage(
      File file, Patient patient, CustomFileType fileType) async {
    UploadTask uploadTask;
    String fileTypeCaption='';
    SettableMetadata settableMetadata;
    // Create a Reference to the file
    Reference ref;
    switch (fileType) {
      case CustomFileType.pdf:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('rays')
            .child('pdf_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          contentType: 'application/pdf',
        );
        fileTypeCaption ="pdfFiles";
        break;
      case CustomFileType.dicom:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('rays')
            .child('dicom_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          // contentType: 'application/zip',
        );
        fileTypeCaption ="dicomFiles";
        break;
      case CustomFileType.image:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('rays')
            .child('image_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          contentType: 'image/jpg',
        );
        fileTypeCaption ="imageFiles";
        break;
    }
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), settableMetadata);
    } else {
      ref.putFile(file, settableMetadata).then((task) async {
        String uri = await task.ref.getDownloadURL();
        postPatientFileUrl(patient, uri,fileTypeCaption);
      });
    }
  }
  @override
  Future<void> uploadMedicalTestFileToStorage(
      File file, Patient patient, CustomFileType fileType,TestData testData,String testID) async {
    UploadTask uploadTask;
    String fileTypeCaption='';
    SettableMetadata settableMetadata;
    // Create a Reference to the file
    Reference ref;
    switch (fileType) {
      case CustomFileType.pdf:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('medicalTests')
            .child('pdf_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          contentType: 'application/pdf',
        );
        fileTypeCaption ="pdfFiles";
        break;
      case CustomFileType.dicom:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('medicalTests')
            .child('dicom_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          // contentType: 'application/zip',
        );
        fileTypeCaption ="dicomFiles";
        break;
      case CustomFileType.image:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('medicalTests')
            .child('image_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          contentType: 'image/jpg',
        );
        fileTypeCaption ="imageFiles";
        break;
    }
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), settableMetadata);
    } else {
      ref.putFile(file, settableMetadata).then((task) async {
        String uri = await task.ref.getDownloadURL();
        testData.details=uri;
        postMedicalTestData(patient, testData,testID);
      });
    }
  }

  @override
  Future<void> postPatientFileUrl(Patient patient, String uri,String fileType) async {
    Map<String, dynamic> updates = {};
    updates = {
      RandomPasswordGenerator()
          .randomPassword(
              letters: true,
              numbers: true,
              passwordLength: 10,
              specialChar: false,
              uppercase: false)
          .toString(): uri
    };
    return await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('patientRays')
        .child(fileType)
        .update(updates);
    // updates['/patients/${patient.uid}/medicalRecord/patientRays/'] = Rays(pdfRays: [uri]).toJson();

    /*   return await FirebaseDatabase.instance.ref().set({
      'orderCheckoutDetails' : FieldValue.arrayUnion([checkout.toDocument])
    });*/ /*.update(updates);*/
  }

  @override
  Future<void> postPatientTests(Patient patient,MedicalTests medicalTests) async {
    Map<String, dynamic> updates = {};
    String testID =RandomPasswordGenerator()
        .randomPassword(
        letters: false,
        numbers: true,
        passwordLength: 14,
        specialChar: false,
        uppercase: false)
        .toString();
    medicalTests.testID=testID;
    updates = {
      testID: medicalTests.toJson()
    };
    return await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('medicalTests')
        .update(updates);
  }
  @override
  Future<List<MedicalTests>> getPatientTests(Patient patient) async {
    var data =await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord').get();
    Map<String,dynamic> map=Map<String,dynamic>.from(data.value as Map);
    return map ['medicalTests']!= null? getMedicalTestList(map ['medicalTests'] ):[];
  }

  @override
  Future<void> postMedicalTestData(Patient patient,TestData testData, String testID) async {
    Map<String, dynamic> updates = {};
    String testDataID =RandomPasswordGenerator()
        .randomPassword(
        letters: false,
        numbers: true,
        passwordLength: 14,
        specialChar: false,
        uppercase: false)
        .toString();
    testData.testDataID=testDataID;
    updates = {
      testDataID: testData.toJson()
    };
    return  await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('medicalTests')
        .child('${testID}')
        .child('testData').update(updates);
  }

  @override
  Future<void> postPatientPrescription(Patient patient,Prescription prescription) async {
    Map<String, dynamic> updates = {};
    String prescriptionID =RandomPasswordGenerator()
        .randomPassword(
        letters: false,
        numbers: true,
        passwordLength: 14,
        specialChar: false,
        uppercase: false)
        .toString();
    prescription.prescriptionID=prescriptionID;
    updates = {
      prescriptionID: prescription.toJson()
    };
    return await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('prescriptions')
        .update(updates);
  }
  @override
  Future<void> updateMedicine(Patient patient,Prescription prescription, Medicine medicine,bool isNewPrescription) async {

    return  await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('prescriptions')
        .child('${prescription.prescriptionID}')
        .child('medicines').child('${medicine.key}').child("medicineName")
        .set('${medicine.medicineName}');

  }  @override
  Future<void> deleteMedicine(Patient patient,Prescription prescription, String medicineIndex) async {
    return  await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('prescriptions')
        .child('${prescription.prescriptionID}')
        .child('medicines').child('${medicineIndex}').remove();
  }
  @override
  Future<void> deletePrescription(Patient patient,Prescription prescription) async {
    return  await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord')
        .child('prescriptions')
        .child('${prescription.prescriptionID}').remove();
  }
  @override
  Future<List<Prescription>> getPatientPrescription(Patient patient) async {
    var data =await FirebaseDatabase.instance
        .ref()
        .child('patients')
        .child(patient.uid)
        .child('medicalRecord').get();
    Map<String,dynamic> map=Map<String,dynamic>.from(data.value as Map);
    return map ['prescriptions']!= null? getPrescriptionsList(map ['prescriptions'] ):[];
  }

  @override
  Future<Patient> getUpdatedPatientFile(String uid)async {
    final  data = await fetchPatientData(uid);
    Map<String,dynamic>map= Map<String,dynamic>.from(data as Map) ;
    return Patient.fromJson(map);
  }
}

// call API
fetchPatientData(String uid) async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('patients')
      .child(uid).get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    return 'No data available.';
  }
}
