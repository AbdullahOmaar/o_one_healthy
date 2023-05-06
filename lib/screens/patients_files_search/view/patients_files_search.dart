import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PatientsFilesSearchScreen extends StatefulWidget {
  const PatientsFilesSearchScreen({Key? key}) : super(key: key);

  @override
  State<PatientsFilesSearchScreen> createState() => _PatientsFilesSearchScreenState();
}

class _PatientsFilesSearchScreenState extends State<PatientsFilesSearchScreen> {

  @override
  void initState() {
     callData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Text("PatientsFilesSearchScreen"),
      ),
    );
  }
}

callData()async{
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('patients').get();
  if (snapshot.exists) {
    print(snapshot.value);
  } else {
    print('No data available.');
  }
}