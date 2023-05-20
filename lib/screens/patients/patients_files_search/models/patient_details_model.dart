class PatientDetails {
  int? age;

  String? imgUrl;

  PatientDetails({this.age, this.imgUrl});

  factory PatientDetails.fromJson(Map<Object?, Object?> json) =>
      PatientDetails(age: int.tryParse(json['age'].toString()), imgUrl: json['imgUrl'].toString());

  toJson() => {"age": age, "imgUrl": imgUrl};
}
