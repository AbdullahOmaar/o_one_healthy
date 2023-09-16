import 'package:app/util/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/doctor_dashboard_screen/models/user_data_model.dart';
import '../../../screens/patients/patients_file/patient_file_view_model/patients_file_view_model.dart';
import '../../../screens/patients/patients_files_search/models/patient_model.dart';
import '../../../util/constant.dart';
import '../../../util/theme/styles.dart';


class TestDataListView extends ConsumerStatefulWidget {

  MedicalTests medicalTests;
  TestDataListView({super.key,required this.medicalTests});

  @override
  ConsumerState<TestDataListView>  createState() => MyAppState();
}

class MyAppState extends ConsumerState<TestDataListView> {

  @override
  void initState() {
    super.initState();
  }

   @override
  void didUpdateWidget(TestDataListView oldWidget) {
     super.didUpdateWidget(oldWidget);
  }

  Widget buildDeleteDialogButtons(String buttonText,Color btnColor,VoidCallback onPressed,) {
    return SizedBox(
      width: 28.w,
      child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: btnColor/*ThemeColors.kPrimary*/,),
          onPressed:onPressed /*() async{
            Navigator.of(context).pop();
          }*/,
          child:Text(
            "$buttonText",
            style:tsS16W500CkLightBlue,
          )
      ),
    );
  }
  Widget _buildTestItem(TestData testData,  int index) {
    switch(testData.testDataType){
      case TestDataType.PDF:
        return buildMedicalTestPDFWidget(testData);
      case TestDataType.Image:
        return buildMedicalTestImageWidget(testData);
      case TestDataType.Report:
        return buildMedicalReportWidget(testData);
      default:
        return SizedBox();
    }
  }
  Widget getCreatorDetailsWidget(User? user){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 10.w,
          height: 10.w,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Images.profile,
                fit: BoxFit.fill,
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text("${user!.name}",style: tsS12W500CkBlack,),
          ],
        ),

      ],
    );
  }
  buildMedicalReportWidget(TestData testData){
    return  Row(
      children: [
        if(testData.creator!=null)
          getCreatorDetailsWidget(testData.creator),
        Expanded(
          child: Container(
            height: 8.h,
            margin: const EdgeInsets.only(
              left: 22.0,
              right: 22.0,
              bottom: 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      testData.details??'',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () => null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  buildMedicalTestImageWidget(TestData testData){
    return  Row(
      children: [
        if(testData.creator!=null)
          getCreatorDetailsWidget(testData.creator),
        Expanded(
          child: Container(
            height: 20.h,
            width: 70.h,
            decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(80)
            ),
            margin: const EdgeInsets.only(
              left: 22.0,
              right: 22.0,
              bottom: 0,
            ),
            child: Image.network(testData.details??'',fit: BoxFit.cover,),
          ),
        ),
      ],
    );
  }
  buildMedicalTestPDFWidget(TestData testData){
    return  Row(
      children: [
        if(testData.creator!=null)
          getCreatorDetailsWidget(testData.creator),
        Expanded(
          child: Container(
            height: 20.h,
            width: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80)
            ),
            margin: const EdgeInsets.only(
              left: 22.0,
              right: 22.0,
              bottom: 0,
            ),
            child: Icon(
              Icons.picture_as_pdf,
              size: MediaQuery.of(context).size.width * .20,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context,index)=>Container(
          margin:  EdgeInsets.symmetric(vertical: 0.5.h),
          height: 1,
          color: Colors.black38,
        ),
        physics: BouncingScrollPhysics(),
        shrinkWrap: false,
        itemCount: widget.medicalTests.testDataList!.length,
        itemBuilder: (context, index) {
          TestData testData =widget.medicalTests.testDataList![index];

          if (index < widget.medicalTests.testDataList!.length) {
            return testData.details=="undefined" ?SizedBox():_buildTestItem(testData, index);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildList()
      ]),
    );
  }
}
