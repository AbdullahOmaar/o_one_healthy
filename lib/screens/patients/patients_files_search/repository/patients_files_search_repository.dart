
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/patient_model.dart';
abstract class IPatientsFilesRepository {
  Future<List<Patient>> getPatientsFilesSearchServices();
  Future<void> createPatient(Patient patient);
  Future<bool> checkPatientExisting(String uid);
}

final  patientsFilesRepositoryProvider = Provider((ref) => PatientsFilesRepository());

class PatientsFilesRepository extends IPatientsFilesRepository {
  @override
  Future<List<Patient>> getPatientsFilesSearchServices() async{
     final  data = await fetchPatientData();
     Map<String,dynamic>m= Map<String,dynamic>.from(data as Map) ;
    List<Patient> list=[];
     for (var element in Map<String,dynamic>.from(m['patients'] as Map ).values) {
       list.add(Patient.fromJson(Map<String,dynamic>.from(element)));
     }
     return  list;
  }

  @override
  Future<void> createPatient(Patient patient) async{
    await _writeNewUser(patient);
  }

  @override
  Future<bool> checkPatientExisting(String uid) async{
    var data =await FirebaseDatabase.instance.ref().child('patients').child(uid).get();
    return data.exists;
  }
}
Future<void> _writeNewUser(Patient user) async {

  // Write the new post's data simultaneously in the posts list and the
  // user's post list.
  final Map<String, Map> updates = {};
  updates['/patients/${user.uid}'] = user.toJson();

  return await FirebaseDatabase.instance.ref().update(updates);
}

// call API
fetchPatientData()async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    return 'No data available.';
  }
}


void writeNewData(String nameEN, String usernameAR, double uid,) async {
  // A post entry.
  final postData = {
    "nameAR": usernameAR,
    "nameEN": nameEN,
    "uid": uid,
    "isLocked": false,
    "isPassword": true,
    "deletes": {
      "age": 18,
      "imageURL": "http/"
    }
  };

  // Get a key for a new Post.
  final newPostKey =
      FirebaseDatabase.instance.ref().child('posts').push().key;

  // Write the new post's data simultaneously in the posts list and the
  // user's post list.
  final Map<String, Map> updates = {};
  updates['/patients/$uid'] = postData;

  return FirebaseDatabase.instance.ref().update(updates);
}

// Patients object

// PatientData = {
//     "nameAR": "usernameAR",
//     "nameEN": "nameEN",
//     "uid": 1749837489,
//     "isLocked": false,
//     "isPassword": true,
//     "deletes": {
//     "age": 18,
//     "imageURL": "http/"
//     }
// }