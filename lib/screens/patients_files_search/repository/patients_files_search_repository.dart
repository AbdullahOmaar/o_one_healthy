
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IPatientsFilesRepository {
  Future<dynamic> getPatientsFilesSearchServices(serviceUrl);
}

final  patientsFilesRepositoryProvider = Provider((ref) => PatientsFilesRepository());

class PatientsFilesRepository extends IPatientsFilesRepository {
  @override
  Future<dynamic> getPatientsFilesSearchServices(serviceUrl) async{
     final data = await callData();
     print(data);
     return data;
  }
}

// call API
callData()async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('patients').get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    return 'No data available.';
  }
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