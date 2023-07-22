import 'package:app/screens/patients/patients_file/view/widgets/medicine.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../patients/patients_file/view/widgets/Rays.dart';
import '../../../patients/patients_files_search/models/patient_model.dart';

class FileTabs extends StatefulWidget {
  Patient patient;
  FileTabs({Key? key, required this.patient}) : super(key: key);

  @override
  _FileTabsState createState() => _FileTabsState();
}

class _FileTabsState extends State<FileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedColor = ThemeColors.kPrimary;

  final _iconTabs = [
    getTapItem(Images.rays, "patients.rays".tr(),),
    getTapItem(Images.analyzes, "patients.analyzes".tr(),),
    getTapItem(Images.medicine, "patients.medicine".tr(),),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            controller: _tabController,
            tabs: _iconTabs,
            unselectedLabelColor: Colors.black,
            labelColor: _selectedColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: _selectedColor.withOpacity(0.2),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                  RaysScreen(patient: widget.patient,),
                  const Center(child: Text('1')),
                  const Medicine(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 Widget getTapItem(String img , String txt) {
    return SizedBox(
        // width: 50.w,
        height: 12.h,
        child: Tab(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                img,
                width: 40.0,
                height: 40.0,
              ),
              Text(
                txt,
                style: tsS16W800CkPrimary,
              )
            ],
          )),
        ));
  }