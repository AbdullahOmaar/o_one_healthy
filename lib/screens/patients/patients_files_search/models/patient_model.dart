import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';

class Patient {
  String nameAR;

  String nameEN;

  String uid;

  bool isLocked;

  bool isPassword;

  PatientDetails? patientDetails;
  Patient(
      {required this.nameAR,
      required this.nameEN,
      required this.uid,
      required this.isLocked,
      required this.isPassword,
      this.patientDetails});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
      nameAR: json['nameAR'],
      nameEN: json['nameEN'],
      uid: json['uid'],
      isLocked: json['isLocked'],
      isPassword: json['isPassword'],
      patientDetails: json['details'] != null
          ? PatientDetails.fromJson(json['details'])
          : null);

  toJson() => {
        "nameAR": nameAR,
        "nameEN": nameEN,
        "uid": uid,
        "isLocked": isLocked,
        "isPassword": isPassword,
        "details": patientDetails?.toJson()
      };
}
