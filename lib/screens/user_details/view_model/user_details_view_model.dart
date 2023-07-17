import 'package:app/screens/user_details/model/user_details_model.dart';

UserDataModel userDetails = UserDataModel.fromJson(data);

Map<String, Object> data = {
  "name": "DR: Mohamed Ali",
  "phone": "01020301472",
  "birthdate": "2012-04-23",
  "image": "http",
  "specialty": "doctor",
  "rating": 3.0,
  "experience": 3,
  "details":
      "A doctor, also known by the less common name Al-Assi, is someone who has studied and practiced the science of medicine. He examines the sick, diagnoses them with disease, and gives them a prescription in which he writes the medicine. And the doctor, after his graduation, practices general medicine. And if he continues his studies, he specializes in a specific field of.",
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
