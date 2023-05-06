
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