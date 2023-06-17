import 'package:app/screens/doctor_dashboard_screen/models/user_data_model.dart';
import 'package:flutter/material.dart';


class UserCard extends StatelessWidget {
  final User user;

  // final Patient user;
  TextEditingController userFilePasswordTEC = TextEditingController();

  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: screenSize.width * 0.45,
        child: Card(
          margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          // color: user.privileges.isAdmin ? Colors.indigo : Colors.white70,
          color: Colors.indigo,
          elevation: 20,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 2, 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                Image.asset('assets/images/logo/logo.jpeg')
                                    .image
                            /*user.userDetails?.imgUrl == null
                          ? Image.asset('assets/images/logo/logo.jpeg').image
                          : NetworkImage(user.userDetails?.imgUrl ?? ''),*/
                            ),
                      ),
                      getPatientNameText(user.name, user.privileges.isAdmin),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                    clipBehavior: Clip.hardEdge,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(.15),
                        borderRadius: BorderRadius.circular(15)),
                    child: Wrap(
                      runSpacing: 4,
                      // runAlignment: WrapAlignment.start,
                      spacing: 2,
                      direction: Axis.horizontal,
                      // scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: false,
                      children: [
                        if (user.privileges.isAdmin)
                          getPrivilegeChip("admin", screenSize),
                        if (user.privileges.isClinic)
                          getPrivilegeChip("Clinic", screenSize),
                        if (user.privileges.isDoctor)
                          getPrivilegeChip("Doctor", screenSize),
                        if (user.privileges.isLaboratory)
                          getPrivilegeChip("Lab", screenSize),
                        if (user.privileges.isPharmacy)
                          getPrivilegeChip("Pharmacy", screenSize),
                        if (user.privileges.hasAdsPrivileges)
                          getPrivilegeChip("Control Ads", screenSize)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPrivilegeChip(String text, Size screenSize) => SizedBox(
        width: screenSize.width * 0.15,
        height: screenSize.height * 0.04,
        child: Chip(
          label: Text(
            text,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 7,
          backgroundColor: Colors.green.shade300.withOpacity(.35),
        ),
      );

  Widget getPatientNameText(String text, bool isAdmin) => Text(
        text,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isAdmin ? Colors.white : Colors.indigo),
      );
}
