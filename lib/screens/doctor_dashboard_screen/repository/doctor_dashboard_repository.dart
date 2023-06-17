
import 'package:app/screens/subscribers_screen/models/subscribe_request.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_data_model.dart';

abstract class IDoctorDashboardRepo {
  Future<void> createUser(User user);
  Future<void> createSubscriptionRequest(SubscribeRequest subscribeRequest);
  Future<bool> checkUserExisting(String uid);
  Future<List<User>> getAllUsersFiles();
  Future<List<SubscribeRequest>> getAllRequests();
  Future<void> deleteSubscriptionRequest(SubscribeRequest request);
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
  @override
  Future<List<SubscribeRequest>> getAllRequests() async{
    final  data = await _fetchRequests();
    Map<String,dynamic>map= Map<String,dynamic>.from(data as Map) ;
    List<SubscribeRequest> list=[];
    if(map['subscriptionRequests']!=null) {
      for (var element
          in Map<String, dynamic>.from(map['subscriptionRequests'] as Map)
              .values) {
        list.add(SubscribeRequest.fromJson(Map<String, dynamic>.from(element)));
      }
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
  _fetchRequests()async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.get();
    if (snapshot.exists) {
      return snapshot.value;
    } else {
      return 'No data available.';
    }
  }

  @override
  Future<void> deleteSubscriptionRequest(SubscribeRequest request)async{
    FirebaseDatabase.instance.ref().child('subscriptionRequests').child(request.phoneNumber).remove();
  }
  Future<void> _writeNewUser(User user) async {

    // Write the new post's data simultaneously in the posts list and the
    // user's post list.
    final Map<String, Map> updates = {};
    updates['/users/${user.uid}'] = user.toJson();

    return await FirebaseDatabase.instance.ref().update(updates);
  }

  Future<void> _writeSubscribeRequest(SubscribeRequest subscribeRequest) async {
    final Map<String, Map> updates = {};
    updates['/subscriptionRequests/${subscribeRequest.phoneNumber}'] = subscribeRequest.toJson();

    return await FirebaseDatabase.instance.ref().update(updates);
  }

  @override
  Future<bool> checkUserExisting(String uid) async{
    var data =await FirebaseDatabase.instance.ref().child('users').child(uid).get();
   return data.exists;
  }

  @override
  Future<void> createSubscriptionRequest(SubscribeRequest subscribeRequest)async {
    await _writeSubscribeRequest(subscribeRequest);
  }
}