import 'package:app/screens/patients/patients_files_search/models/patient_details_model.dart';

import '../../../doctor_dashboard_screen/models/user_data_model.dart';

class Patient {
  String nameAR;
  MedicalRecord? medicalRecord;
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
    this.medicalRecord,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        nameAR: json['nameAR'],
        nameEN: json['nameEN'],
        phoneNumber: json['phoneNumber'] ?? '',
        password: json['password'] ?? '',
        uid: json['uid'],
        isLocked: json['isLocked'] ?? false,
        isPassword: json['isPassword'],
        patientDetails: json['details'] != null
            ? PatientDetails.fromJson(json['details'])
            : null,
        medicalRecord: json['medicalRecord'] != null
            ? MedicalRecord.fromJson(json['medicalRecord'])
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
        "details": patientDetails?.toJson(),
        "medicalRecord": medicalRecord?.toJson()
      };
}

class MedicalRecord {
  Rays? patientRays;

  MedicalRecord({this.patientRays});

  factory MedicalRecord.fromJson(Map<Object?, Object?> json) => MedicalRecord(
        patientRays: json['patientRays'] != null
            ? Rays.fromJson(
                Map<String, dynamic>.from(json['patientRays'] as Map))
            : null,
      );

  toJson() => {"patientRays": patientRays?.toJson()};
}

class Rays {
  List<PDFFile>? pdfRays;
  List<ImageFile>? imageRays;

  List<DicomFile>? dicomRays;

  Rays({this.pdfRays, this.dicomRays,this.imageRays});

  factory Rays.fromJson(Map<String, dynamic> json) {
    return Rays(
        pdfRays: json['pdfFiles']!=null?getPDFRaysList(json['pdfFiles'] as Map):[],
        dicomRays: json['dicomFiles']!=null?getDicomRaysList(json['dicomFiles'] as Map):[],
        imageRays: json['imageFiles']!=null?getImagesRaysList(json['imageFiles'] as Map):[],
    );
  }

  toJson() => {"pdfRays": pdfRays, "dicomRays": dicomRays};
}
abstract class PatientFile{
}
class PDFFile extends PatientFile{
  String? pdfFile;
  PDFFile({this.pdfFile});
  factory PDFFile.fromJson(String json)=>PDFFile(pdfFile :json);
}
class DicomFile extends PatientFile{
  String? dicomFile;
  DicomFile({this.dicomFile});
  factory DicomFile.fromJson(String json)=>DicomFile(dicomFile :json);
}
class ImageFile extends PatientFile{
  String? imageFile;
  ImageFile({this.imageFile});
  factory ImageFile.fromJson(String json)=>ImageFile(imageFile :json);
}
List<PDFFile> getPDFRaysList(Map json) {
  List<PDFFile> raysURLs = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    raysURLs.add(PDFFile(pdfFile: element.toString()));
  }
  return raysURLs;
}
List<ImageFile> getImagesRaysList(Map json) {
  List<ImageFile> raysURLs = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    raysURLs.add(ImageFile(imageFile: element.toString()));
  }
  return raysURLs;
}
List<DicomFile> getDicomRaysList(Map json) {
  List<DicomFile> raysURLs = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    raysURLs.add(DicomFile(dicomFile: element.toString()));
  }
  return raysURLs;
}
