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
  List<Prescription>? prescriptions;
  MedicalRecord({this.patientRays,this.prescriptions});

  factory MedicalRecord.fromJson(Map<Object?, Object?> json) => MedicalRecord(
        patientRays: json['patientRays'] != null
            ? Rays.fromJson(
                Map<String, dynamic>.from(json['patientRays'] as Map))
            : null,
     prescriptions: json['prescriptions']!=null?getPrescriptionsList(json['prescriptions'] as Map):[],

  );

  toJson() => {"patientRays": patientRays?.toJson(),
  };
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

  toJson() => {"pdfRays": pdfRays, "dicomRays": dicomRays ,"imageRays":imageRays};
}
class Prescription {
  List<Medicine>? medicines;
  String? prescriptionID ;
  User? creator;
  String? creationDate;
  Prescription({this.medicines ,this.prescriptionID, this.creator,this.creationDate});

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
        medicines: json['medicines']!=null?getMedicineList(json['medicines'] as Map):[],
        prescriptionID: json['prescriptionID']??'',
        creator:User.fromJson(Map<String,dynamic>.from(json['creator'])),
        creationDate: json["creationDate"]
    );
  }

  toJson() => {
        "medicines": medicines?.map((e) => e.toJson()).toList(),
        "prescriptionID": prescriptionID,
        "creator": creator?.toJson() ,
        "creationDate": creationDate ?? ''
      };
}
abstract class PatientFile{
}
class Medicine extends PatientFile{
  String? medicineName;
  String? key;
  Medicine({this.medicineName,this.key});
  factory Medicine.fromJson(String json)=>Medicine(medicineName :json);
  Map<String ,dynamic> toJson()=>{
    "medicineName":medicineName
  };
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
List<Medicine> getMedicineList(Map json) {
  List<Medicine> medicines = [];
  for (var element in Map<String, dynamic>.from(json).entries){
    // Map<String, dynamic>map= Map<String, dynamic>.from(element as Map);
    medicines.add(Medicine(key:element.key ,medicineName: element!=null?element.value['medicineName'].toString():"undefined"));
  }
  return medicines;
}
List<Prescription> getPrescriptionsList(Map json) {
  List<Prescription> prescriptions = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    prescriptions.add(Prescription.fromJson(Map<String, dynamic>.from(element))
      /*Prescriptions(  medicines:element!=null?getMedicineList(element as Map):[],
    )*/);
  }
  return prescriptions;
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
