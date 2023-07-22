import 'package:app/common/roshata/rosheta_screen.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildButton(),
          ),
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
  return SizedBox(
    width: 45.w,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: ThemeColors.kPrimary,),
      onPressed: () {},
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(
            "patients.add_prescription".tr(),
        style:tsS16W500CkLightBlue,
      ),
      Icon(Icons.add,color:ThemeColors.kLightBlue,),
        ],
      )
    ),
  );
}
