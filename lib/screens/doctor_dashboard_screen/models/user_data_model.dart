class User {
   String name;
   String password;
   String email;
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
    required this.password,
    required this.email,
    this.address,
    this.createdBy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        phoneNumber: json['phone_number']??'',
        uid: json['uid'],
        password: json['password'].toString(),
        email: json['email']??'',
        privileges: Privileges.fromJson(json['privileges']),
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
        createdBy: json['created_by'] != null
            ? CreatedBy.fromJson(json['created_by'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password":password,
        "email":email,
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

  factory Address.fromJson(Map<Object?, Object?> json) => Address(
        country: json['country'].toString(),
        governorate: json['phone_number'].toString(),
        city: json['city'].toString(),
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

  factory CreatedBy.fromJson(Map<Object?, Object?> json) => CreatedBy(
        creatorName: json['creator_name'].toString(),
        creatorUid: json['creator_uid'].toString(),
        createdDate: json['created_date'].toString(),
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

  factory Privileges.fromJson(Map<Object?, Object?> json) => Privileges(
        hasAdsPrivileges: json['hasAdsPrivileges'] as bool,
        isAdmin: json['isAdmin'] as bool,
        isClinic: json['isClinic']as bool,
        isDoctor: json['isDoctor']as bool,
        isLaboratory: json['isLaboratory']as bool,
        isPharmacy: json['isPharmacy']as bool,
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
