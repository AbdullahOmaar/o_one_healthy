
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_data_model.dart';

abstract class IDoctorDashboardRepo {
  Future<void> createUser(User user);
  Future<bool> checkUserExisting(String uid);
}

final  doctorDashboardRepositoryProvider = Provider((ref) => DoctorDashboardRepo());

class DoctorDashboardRepo extends IDoctorDashboardRepo {
  @override
  Future<void> createUser(User user) async{
     await _writeNewUser(user);
  }

  Future<void> _writeNewUser(User user) async {

    // Write the new post's data simultaneously in the posts list and the
    // user's post list.
    final Map<String, Map> updates = {};
    updates['/users/${user.uid}'] = user.toJson();

    return await FirebaseDatabase.instance.ref().update(updates);
  }

  @override
  Future<bool> checkUserExisting(String uid) async{
    var data =await FirebaseDatabase.instance.ref().child('users').child(uid).get();
   return data.exists;
  }
}