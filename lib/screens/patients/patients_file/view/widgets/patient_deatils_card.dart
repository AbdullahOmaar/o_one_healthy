import 'package:flutter/material.dart';

class PatientDetailsCard extends StatefulWidget {
  const PatientDetailsCard({Key? key}) : super(key: key);

  @override
  State<PatientDetailsCard> createState() => _PatientDetailsCardState();
}

class _PatientDetailsCardState extends State<PatientDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/logo/logo.jpeg',
                    fit: BoxFit.fill,
                  )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.deepOrange),
                child: const Icon(
                  Icons.screen_rotation_alt,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text("Mohamed Ahmed", style: Theme.of(context).textTheme.titleLarge),
        Text("0100283043", style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
