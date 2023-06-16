import 'package:flutter/material.dart';

import '../../../doctor_dashboard_screen/models/user_data_model.dart';

class SubscribersCard extends StatelessWidget {
  final User user;

  // final Patient user;
  TextEditingController userFilePasswordTEC = TextEditingController();
   Size? screenSize;
  SubscribersCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize!.width * 0.70,
      child:  Stack(
        fit: StackFit.loose,
        // alignment: const Alignment(0,-.5),
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.indigo,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.1,
                              0.4,
                              0.6,
                            ],
                            colors: [
                              Colors.red,
                              Colors.indigo,
                              Colors.teal,
                            ],
                          )
                      ),
                      width: double.infinity,
                    ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,),
                )
              ],
            ),
          ),
          Align(
            alignment:const Alignment(0,-.3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 72,
                  backgroundColor: Colors.indigo,
                  child: CircleAvatar(backgroundImage:
                  Image.asset('assets/images/logo/logo.jpeg').image,radius: 70,),
                ),
                getUserDetailsBody()
              ],
            ),
          )
        ],
      ),
    );
  }
  getUserDetailsBody()=>Column(
    mainAxisSize: MainAxisSize.min,
    // mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getUserNameTextWidget(user.name),
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          decoration: BoxDecoration(
              // color: Colors.amber.withOpacity(.15),
              borderRadius: BorderRadius.circular(15)),
          child: Wrap(
            runSpacing: 1,
            spacing: 1,
            direction: Axis.horizontal,
            children: [

              if (user.privileges.hasAdsPrivileges)
                getPrivilegeChip("Control Ads"),
              if (user.privileges.isClinic)
                getPrivilegeChip("Clinic"),
              if (user.privileges.isDoctor)
                getPrivilegeChip("Doctor"),
              if (user.privileges.isPharmacy)
                getPrivilegeChip("Pharmacy"),
              if (user.privileges.isAdmin)
                getPrivilegeChip("admin", ),
              if (user.privileges.isLaboratory)
                getPrivilegeChip("Lab"),
            ],
          ),
        ),
      ),
    ],
  );

  Widget getPrivilegeChip(String text,) => SizedBox(
        width: screenSize!.width * 0.20,
        height: screenSize!.height * 0.06,
        child: Chip(
          clipBehavior: Clip.hardEdge,
          label: Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 2,
          backgroundColor: Colors.grey.shade500,
        ),
      );

  Widget getUserNameTextWidget(String text,) => Text(
        text,
        style: const TextStyle(
            fontSize: 18,),
      );
}
