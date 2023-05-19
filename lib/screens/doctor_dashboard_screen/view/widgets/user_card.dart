import 'package:app/common/custom_button.dart';
import 'package:app/common/widget_utils.dart';
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
          color: user.privileges.isAdmin?Colors.indigo:Colors.white70,
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
                          getPatientNameText(user.name ,user.privileges.isAdmin),
                          // if (user.privileges.isAdmin)
/*
                            getPrivilegeContainer("Admin"),
*/
                        // getVerticalSpacerLine(MediaQuery.of(context).size.width, CustomWidth.oneThird, Colors.grey, 16),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              // scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              children: [
                                if (user.privileges.isAdmin)
                                  getPrivilegeContainer("Admin",user.privileges.isAdmin),
                              if (user.privileges.isClinic)
                                  getPrivilegeContainer("Clinic",user.privileges.isAdmin),
                                if (user.privileges.isDoctor)
                                  getPrivilegeContainer("Doctor",user.privileges.isAdmin),
                              ],
                            ),
                          )   ,
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              // scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: false,
                              children: [
                                if (user.privileges.isLaboratory)
                                  getPrivilegeContainer("Lab",user.privileges.isAdmin),
                                if (user.privileges.isPharmacy)
                                  getPrivilegeContainer("Pharmacy",user.privileges.isAdmin),
                                if (user.privileges.hasAdsPrivileges)
                                  getPrivilegeContainer("Control Ads",user.privileges.isAdmin),
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

  getPrivilegeContainer(String text,bool isAdmin) => Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
          decoration: BoxDecoration(
              color: isAdmin?Colors.white:Colors.green.shade300.withOpacity(.35),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const  TextStyle(
                  overflow: TextOverflow.ellipsis, color: Colors.black54,fontSize: 10,fontWeight: FontWeight.bold),
            ),
          ),
        ),
  );

  Widget getPatientNameText(String text ,bool isAdmin) => Text(
        text,
        style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:isAdmin?Colors.white:Colors.indigo
        ),
      );
}
