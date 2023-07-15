class UserDataModel {
  String? name;
  String? phone;
  String? birthdate;
  String? image;
  String? specialty;
  double? rating;
  int? experience;
  String? details;
  List<Days>? days;
  int? fromTime;
  int? toTime;
  int? files;
  int? patient;

  UserDataModel(
      {this.name,
      this.phone,
      this.birthdate,
      this.image,
      this.specialty,
      this.rating,
      this.experience,
      this.details,
      this.days,
      this.fromTime,
      this.toTime,
      this.files,
      this.patient});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    birthdate = json['birthdate'];
    image = json['image'];
    specialty = json['specialty'];
    rating = json['rating'];
    experience = json['experience'];
    details = json['details'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    files = json['files'];
    patient = json['patient'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['birthdate'] = birthdate;
    data['image'] = image;
    data['specialty'] = specialty;
    data['rating'] = rating;
    data['experience'] = experience;
    data['details'] = details;
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['files'] = files;
    data['patient'] = patient;
    return data;
  }
}

class Days {
  bool? saturday;
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;

  Days(
      {this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday});

  Days.fromJson(Map<String, dynamic> json) {
    saturday = json['Saturday'];
    sunday = json['Sunday'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Saturday'] = saturday;
    data['Sunday'] = sunday;
    data['Monday'] = monday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    return data;
  }
}
