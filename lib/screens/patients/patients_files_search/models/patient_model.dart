import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';

import '../../../doctor_dashboard_screen/models/user_data_model.dart';

class Patient {
  String nameAR;

  String nameEN;
  String? password;

  String uid;
  String? phoneNumber;

  bool? isLocked;

  bool isPassword;
  CreatedBy? createdBy;

  PatientDetails? patientDetails;

  Patient({
    required this.nameAR,
    required this.nameEN,
    required this.uid,
    this.isLocked,
    required this.isPassword,
    this.patientDetails,
    this.phoneNumber,
    this.password,
    this.createdBy,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        nameAR: json['nameAR'],
        nameEN: json['nameEN'],
        phoneNumber: json['phoneNumber'] ?? '',
        password: json['password'] ?? '',
        uid: json['uid'],
        isLocked: json['isLocked'] ??false,
        isPassword: json['isPassword'],
        patientDetails: json['details'] != null
            ? PatientDetails.fromJson(json['details'])
            : null,
        createdBy: json['created_by'] != null
            ? CreatedBy.fromJson(json['created_by'])
            : null,
      );

  toJson() => {
        "nameAR": nameAR,
        "nameEN": nameEN,
        "phoneNumber": phoneNumber ?? '',
        "password": password ?? '',
        "uid": uid,
        "isLocked": isLocked ?? false,
        "isPassword": isPassword,
        "created_by": createdBy?.toJson(),
        "details": patientDetails?.toJson()
      };
}
