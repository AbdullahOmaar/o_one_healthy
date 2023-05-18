import 'package:app/screens/doctor_dashboard_screen/models/user_data_model.dart';
import 'package:flutter/material.dart';

import '../../../patients/patients_files_search/models/patient_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  // final Patient user;
  TextEditingController userFilePasswordTEC = TextEditingController();

  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            Image.asset('assets/images/logo/logo.jpeg').image
                        /*user.userDetails?.imgUrl == null
                          ? Image.asset('assets/images/logo/logo.jpeg').image
                          : NetworkImage(user.userDetails?.imgUrl ?? ''),*/
                        ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getPatientNameText(user.name),
                          // if (user.privileges.isAdmin)
/*
                            getPrivilegeContainer("Admin"),
*/
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              // scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              children: [
                                if (user.privileges.isAdmin)
                                  getPrivilegeContainer("Admin"),
                              if (user.privileges.isClinic)
                                  getPrivilegeContainer("Clinic"),
                                if (user.privileges.isDoctor)
                                  getPrivilegeContainer("Doctor"),
                              ],
                            ),
                          )   , Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              // scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              children: [
                                if (user.privileges.isLaboratory)
                                  getPrivilegeContainer("Lab"),
                                if (user.privileges.isPharmacy)
                                  getPrivilegeContainer("Pharmacy"),
                                if (user.privileges.hasAdsPrivileges)
                                  getPrivilegeContainer("Control Ads"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getPrivilegeContainer(String text) => Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
          decoration: BoxDecoration(
              color: Colors.green.shade300.withOpacity(.35),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis, color: Colors.black54,fontSize: 10),
            ),
          ),
        ),
  );

  Widget getPatientNameText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
}
