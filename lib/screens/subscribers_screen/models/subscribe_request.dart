class SubscribeRequest {
   String name;
   String phoneNumber;

  SubscribeRequest({required this.name, required this.phoneNumber});

  factory SubscribeRequest.fromJson(Map<String, dynamic> json) =>
      SubscribeRequest(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
      );
  Map<String ,dynamic> toJson()=>{
    "name":name,
    "phoneNumber":phoneNumber,
  };
}
