import 'package:app/common/roshata/rosheta_screen.dart';
import 'package:flutter/material.dart';

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildButton(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: RoshetaScreen(),
          )
        ],
      ),
    );
  }
}

Widget buildButton() {
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.indigo,
    ),
    onPressed: () {},
    child: const Text(
      'اضافة روشته ',
      style: TextStyle(fontSize: 16),
    ),
  );
}
