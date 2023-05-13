import 'package:app/common/roshata/widget/buld_medicines_list.dart';
import 'package:flutter/material.dart';

class RoshetaScreen extends StatefulWidget {
  const RoshetaScreen({Key? key}) : super(key: key);

  @override
  State<RoshetaScreen> createState() => _RoshetaScreenState();
}

class _RoshetaScreenState extends State<RoshetaScreen> {
  final Map<String, bool> _map = {};
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black54),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          buildDoctorHeaderDetails(),
          const Divider(
            height: 15,
            color: Colors.black,
          ),
          const SizedBox(height: 400, child: BuildMedicinesList()),
          const Divider(
            height: 15,
            color: Colors.black,
          ),
          buildDoctorFooterDetails()
        ],
      ),
    );
  }
}

Widget buildDoctorHeaderDetails() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("دكتور: محمد احمد"),
          Text("تخصص: باطنه"),
        ],
      ),
      SizedBox(
        width: 50,
        height: 50,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/logo/logo.jpeg',
              fit: BoxFit.fill,
            )),
      ),
    ],
  );
}

Widget buildDoctorFooterDetails() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text("هاتف 012127632"),
      Text("الزقازيق"),
    ],
  );
}
