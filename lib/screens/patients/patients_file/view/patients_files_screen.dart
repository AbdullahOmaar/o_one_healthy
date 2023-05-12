import 'package:app/screens/login/view/widgets/tabs.dart';
import 'package:app/screens/patients/patients_file/view/widgets/patient_deatils_card.dart';
import 'package:flutter/material.dart';

class PatientFileScreen extends StatelessWidget {
  static const routeName = "/PatientFileScreen";

  const PatientFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => null,
            icon: const Icon(Icons.supervised_user_circle_outlined)),
        title: const Text("User Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            PatientDetailsCard(),
            SizedBox(height: 500, child: FileTabs())
          ],
        ),
      ),
    );
  }
}
