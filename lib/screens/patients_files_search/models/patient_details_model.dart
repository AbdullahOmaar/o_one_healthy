class PatientDetails {
  int? age;

  String? imgUrl;

  PatientDetails({this.age, this.imgUrl});

  factory PatientDetails.fromJson(Map<String, dynamic> json) =>
      PatientDetails(age: json['age'], imgUrl: json['imgUrl']);

  toJson() => {"age": age, "imgUrl": imgUrl};
}
