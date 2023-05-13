
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../doctor_dashboard_screen/models/user_data_model.dart';

abstract class ILoginRepository {
  Future<dynamic> getLoginServices(serviceUrl);
  Future<bool> checkUserExistence(String uid,String password);
  Future<User> getUserData(String uid);
}

final  loginRepositoryProvider = Provider((ref) => LoginRepository());

class LoginRepository extends ILoginRepository {
  @override
  Future<dynamic> getLoginServices(serviceUrl) async{
    return "";
  }

  @override
  Future<bool> checkUserExistence(String uid, String password) async{
    var uidSnap =await FirebaseDatabase.instance.ref().child('users').child(uid).get();
    if (uidSnap.exists){
      var passSnap =await FirebaseDatabase.instance.ref().child('users').child(uid).child("password").get();
      if(passSnap.exists) {
        return password.trim() ==passSnap.value.toString().trim();
      } else {
        return false;
      }
    }else{
      return false;
    }
  }

  @override
  Future<User> getUserData(String uid) async{
    var userData =await FirebaseDatabase.instance.ref().child('users').child(uid).get();
    Map<String,dynamic>userMap= Map<String,dynamic>.from(userData.value as Map) ;
    return User.fromJson(userMap);
  }

}