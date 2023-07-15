import 'package:app/screens/user_details/model/user_details_model.dart';

UserDataModel userData = UserDataModel.fromJson(data);

Map<String, Object> data = {
  "name": "Ahmed",
  "phone": "010000000",
  "birthdate": "2012-04-23",
  "image": "http",
  "specialty": "doctor",
  "rating": 3.0,
  "experience": 3,
  "details": "heellllll",
  "days": [
    {"Saturday": true},
    {"Sunday": false},
    {"Monday": false},
    {"Tuesday": false},
    {"Wednesday": true},
    {"Thursday": true},
    {"Friday": true}
  ],
  "fromTime": 9,
  "toTime": 4,
  "files": 15,
  "patient": 20
};
