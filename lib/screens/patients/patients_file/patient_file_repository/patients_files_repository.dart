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

  Future<void> uploadFileToStorage(
      File file, Patient patient, FileType fileType);
}

enum FileType { pdf, dicom, image }

final filesRepositoryProvider = Provider((ref) => FilesRepository());

class FilesRepository extends IFilesRepository {
  @override
  Future<void> uploadFileToStorage(
      File file, Patient patient, FileType fileType) async {
    UploadTask uploadTask;
    String fileTypeCaption='';
    SettableMetadata settableMetadata;
    // Create a Reference to the file
    Reference ref;
    switch (fileType) {
      case FileType.pdf:
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
      case FileType.dicom:
        ref = FirebaseStorage.instance
            .ref()
            .child('patientRecords')
            .child(patient.uid.toString())
            .child('rays')
            .child('dicom_files')
            .child(Uri.file(file.path).pathSegments.last);
        settableMetadata = SettableMetadata(
          contentType: 'image/dicom',
        );
        fileTypeCaption ="dicomFiles";
        break;
      case FileType.image:
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
}

// call API
fetchPatientData() async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    return 'No data available.';
  }
}
