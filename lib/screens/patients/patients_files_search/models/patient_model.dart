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
  List<MedicalTests>? medicalTests;
  MedicalRecord({this.patientRays,this.prescriptions,this.medicalTests});

  factory MedicalRecord.fromJson(Map<Object?, Object?> json) => MedicalRecord(
        patientRays: json['patientRays'] != null
            ? Rays.fromJson(
                Map<String, dynamic>.from(json['patientRays'] as Map))
            : null,
     prescriptions: json['prescriptions']!=null?getPrescriptionsList(json['prescriptions'] as Map):[],
     medicalTests: json['medicalTests']!=null?getMedicalTestList(json['medicalTests'] as Map):[],

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
    final bool isList =json['medicines'].runtimeType==List<Object?>;
    return Prescription(
        medicines: json['medicines']!=null?isList?getMedicineListFromListOfObject(json['medicines'] as List<Object?>):getMedicineList(json['medicines'] as Map):[],
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

class MedicalTests {
  List<Test>? test;
  List<TestData>? testDataList;
  String? testID ;
  User? creator;
  String? creationDate;
  MedicalTests({this.test ,this.testID, this.creator,this.creationDate,this.testDataList});

  factory MedicalTests.fromJson(Map<String, dynamic> json) {
    final bool isList =json['test'].runtimeType==List<Object?>;
    final bool isListOfTestData =json['testDataList'].runtimeType==List<Object?>;
    return MedicalTests(
        test: json['test']!=null?isList?getTestListFromListOfObject(json['test'] as List<Object?>):getTestList(json['test'] as Map):[],
        testDataList: json['testData']!=null?getTestDataList(json['testData'] as Map):[],
        testID: json['testID']??'',
        creator:User.fromJson(Map<String,dynamic>.from(json['creator'])),
        creationDate: json["creationDate"]
    );
  }

  toJson() => {
        "test": test?.map((e) => e.toJson()).toList(),
        "testData": testDataList?.map((e) => e.toJson()).toList(),
        "testID": testID,
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
class Test {
  String? testName;
  String? key;
  Test({this.testName,this.key});
  factory Test.fromJson(String json)=>Test(testName :json);
  Map<String ,dynamic> toJson()=>{
    "testName":testName
  };
}
class TestData {
  String? details;
  String? key;
  String ? testDataID;
  TestDataType? testDataType;
  User? creator;
  String? creationDate;
  TestData({this.details,this.key,this.testDataType,this.creationDate,this.testDataID,this.creator});
  factory TestData.fromJson(Map<String, dynamic> json)=>TestData(
      details :json["details"],
      testDataID :json["testDataID"],
      creator:User.fromJson(Map<String,dynamic>.from(json['creator'])),

      creationDate :json["creationDate"],
      testDataType: parseTestDataFromString(json["testDataType"])
  );
  Map<String ,dynamic> toJson()=>{
    "details":details??'',
    "creator":creator?.toJson(),
    "testDataID":testDataID??'',
    "testDataType":testDataType.toString()??'',
    "creationDate":creationDate??''
  };
}
TestDataType parseTestDataFromString(String testData){
  switch (testData){
    case "TestDataType.Image":
      return TestDataType.Image;
    case "TestDataType.PDF":
      return TestDataType.PDF;
    case "TestDataType.Report":
      return TestDataType.Report;
    default:
      return TestDataType.Report;
  }
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
    medicines.add(Medicine(key:element.key ,medicineName: element!=null?element.value['medicineName'].toString():"undefined"));
  }
  return medicines;
}
List<Medicine> getMedicineListFromListOfObject(List<Object?> json) {
  List<Medicine> medicines = [];
  for (var element in Map<dynamic, dynamic>.fromIterable(json).entries){
    // Map<String, dynamic>map= Map<String, dynamic>.from(element as Map);
    medicines.add(Medicine(key:element.key.toString() ,medicineName: element!=null?element.value['medicineName'].toString():"undefined"));
  }
  return medicines;
}


List<Test> getTestList(Map json) {
  List<Test> tests = [];
  for (var element in Map<String, dynamic>.from(json).entries){
    tests.add(Test(key:element.key ,testName: element!=null?element.value['testName'].toString():"undefined"));
  }
  return tests;
}
List<Test> getTestListFromListOfObject(List<Object?> json) {
  List<Test> tests = [];
  for (var element in Map<dynamic, dynamic>.fromIterable(json).entries){
    // Map<String, dynamic>map= Map<String, dynamic>.from(element as Map);
    tests.add(Test(key:element.key.toString() ,testName: element!=null?element.value['testName'].toString():"undefined"));
  }
  return tests;
}


List<TestData> getTestDataList(Map json) {
  List<TestData> testDataList = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    testDataList.add(TestData.fromJson(Map<String, dynamic>.from(element)));
  }
  return testDataList;
}
List<TestData> getTestDataListFromListOfObject(List<Object?> json) {
  List<TestData> testDataList = [];
  for (var element in Map<dynamic, dynamic>.fromIterable(json).entries){
    // Map<String, dynamic>map= Map<String, dynamic>.from(element as Map);
    testDataList.add(TestData(key:element.key ,details: element!=null?element.value['details'].toString():"undefined",
        creationDate:element.value['creationDate'],
        testDataID: element.value['creationDate'],
        testDataType:parseTestDataFromString(element.value['testDataType']) ));
  }
  return testDataList;
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
List<MedicalTests> getMedicalTestList(Map json) {
  List<MedicalTests> medicalTest = [];
  for (var element in Map<String, dynamic>.from(json).values) {
    medicalTest.add(MedicalTests.fromJson(Map<String, dynamic>.from(element))
      /*Prescriptions(  medicines:element!=null?getMedicineList(element as Map):[],
    )*/);
  }
  return medicalTest;
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
enum TestDataType{
  Image,
  PDF,
  Report
}
