class User {
   String name;
   String phoneNumber;
   String uid;
  Address? address;
  CreatedBy? createdBy;
  Privileges privileges;

  User({
    required this.name,
    required this.phoneNumber,
    required this.uid,
    required this.privileges,
    this.address,
    this.createdBy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        phoneNumber: json['phone_number'],
        uid: json['uid'],
        privileges: Privileges.fromJson(json['privileges']),
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
        createdBy: json['created_by'] != null
            ? CreatedBy.fromJson(json['created_by'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "uid": uid,
        "address": address?.toJson(),
        "created_by": createdBy?.toJson(),
        "privileges": privileges.toJson(),
      };
}

class Address {
   String country;
   String governorate;
   String city;

  Address(
      {required this.country, required this.governorate, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json['country'],
        governorate: json['phone_number'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "phone_number": governorate,
        "city": city,
      };
}

class CreatedBy {
   String creatorName;
   String creatorUid;
   String createdDate;

  CreatedBy(
      {required this.creatorName,
      required this.creatorUid,
      required this.createdDate});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        creatorName: json['creator_name'],
        creatorUid: json['creator_uid'],
        createdDate: json['created_date'],
      );

  Map<String, dynamic> toJson() => {
        "creator_name": creatorName,
        "creator_uid": creatorUid,
        "created_date": createdDate,
      };
}

class Privileges {
   bool hasAdsPrivileges;
   bool isAdmin;
   bool isClinic;
   bool isDoctor;
   bool isLaboratory;
   bool isPharmacy;


  Privileges({
    required this.hasAdsPrivileges,
    required this.isAdmin,
    required this.isClinic,
    required this.isDoctor,
    required this.isLaboratory,
    required this.isPharmacy,
  });

  factory Privileges.fromJson(Map<String, dynamic> json) => Privileges(
        hasAdsPrivileges: json['hasAdsPrivileges'],
        isAdmin: json['isAdmin'],
        isClinic: json['isClinic'],
        isDoctor: json['isDoctor'],
        isLaboratory: json['isLaboratory'],
        isPharmacy: json['isPharmacy'],
      );

  Map<String, dynamic> toJson() => {
        "hasAdsPrivileges": hasAdsPrivileges,
        "isAdmin": isAdmin,
        "isClinic": isClinic,
        "isDoctor": isDoctor,
        "isLaboratory": isLaboratory,
        "isPharmacy": isPharmacy,
      };
}
