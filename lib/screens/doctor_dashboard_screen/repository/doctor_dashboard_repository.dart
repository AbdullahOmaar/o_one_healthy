
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_data_model.dart';

abstract class IDoctorDashboardRepo {
  Future<void> createUser(User user);
  Future<bool> checkUserExisting(String uid);
  Future<List<User>> getAllUsersFiles();
}

final  doctorDashboardRepositoryProvider = Provider((ref) => DoctorDashboardRepo());

class DoctorDashboardRepo extends IDoctorDashboardRepo {
  @override
  Future<void> createUser(User user) async{
     await _writeNewUser(user);
  }
  @override
  Future<List<User>> getAllUsersFiles() async{
    final  data = await _fetchUsers();
    Map<String,dynamic>map= Map<String,dynamic>.from(data as Map) ;
    List<User> list=[];
    for (var element in Map<String,dynamic>.from(map['users'] as Map ).values) {
      list.add(User.fromJson(Map<String,dynamic>.from(element)));
    }
    return  list;
  }

  _fetchUsers()async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.get();
    if (snapshot.exists) {
      return snapshot.value;
    } else {
      return 'No data available.';
    }
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