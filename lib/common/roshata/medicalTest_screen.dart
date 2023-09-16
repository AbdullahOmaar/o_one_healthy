import 'dart:convert';
import 'dart:io';

import 'package:app/common/roshata/widget/buldMedicalTestList.dart';
import 'package:app/common/roshata/widget/buld_medicines_list.dart';
import 'package:app/common/roshata/widget/testDataListView.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../screens/doctor_dashboard_screen/models/user_data_model.dart';
import '../../screens/patients/patients_file/patient_file_repository/patients_files_repository.dart';
import '../../screens/patients/patients_file/patient_file_view_model/patients_file_view_model.dart';
import '../../screens/patients/patients_files_search/models/patient_model.dart';

class MedicalTestScreen extends ConsumerStatefulWidget {
  Patient patient;
  MedicalTests medicalTests;
   MedicalTestScreen({Key? key,required this.patient,required this.medicalTests}) : super(key: key);

  @override
  ConsumerState<MedicalTestScreen> createState() => _MedicalTestScreenState();
}

class _MedicalTestScreenState extends ConsumerState<MedicalTestScreen> {
  final TextEditingController _controller = TextEditingController();
  TestData testData =TestData();
  @override
  Widget build(BuildContext context) {
    widget.patient=ref.watch(fileViewModelProvider).currentPatient!;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeColors.roshetaBG,
        border: Border.all(width: 2, color:ThemeColors.kPrimary),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          buildDoctorHeaderDetails(),
          buildDoctorFooterDetails(),
          SizedBox(height: 30.h,
           child: Card(
            margin: EdgeInsets.all(8.0),
            child: BuildTestsList(isNewMedicalTests:false,medicalTests: widget.medicalTests,patient: widget.patient,),
            color:Colors.white,
            shadowColor:Colors.grey.shade200,
            elevation: 1.0,
            shape:RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
            )),
          buildLabActions(),
          if(widget.medicalTests.testDataList!.isNotEmpty)
            SizedBox(
                height: 30.h,
                child: TestDataListView(
                  medicalTests: widget.medicalTests,
                ))
        ],
      ),
    );
  }
  buildLabActions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: ElevatedButton(onPressed: (){
          filePickAction(CustomFileType.image);
          Future.delayed(Duration(seconds: 0),()async{
            await ref
                .read(fileViewModelProvider.notifier).fetchPatientTests( widget.patient);
          });
        }, child: Text('Add image'))),
        Expanded(child: ElevatedButton(onPressed: ()async{
         await filePickAction(CustomFileType.pdf);
         Future.delayed(Duration(seconds: 0),()async{
           await ref
               .read(fileViewModelProvider.notifier).fetchPatientTests( widget.patient);
         });
        }, child: Text('Add PDF'))),
        Expanded(child: ElevatedButton(onPressed: ()=>_reportDialog(context), child: Text('Add report'))),
      ],);
  }
  Future<void> filePickAction(CustomFileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String fileName =
          Uri.file(result.files.single.path ?? '').pathSegments.last;
      if (fileName.substring(fileName.lastIndexOf('.')).contains('pdf') ||
          fileName.substring(fileName.lastIndexOf('.')).contains('jpg') ||
          fileName.substring(fileName.lastIndexOf('.')).contains('png')) {
        FlutterSecureStorage storage = const FlutterSecureStorage();
        String? data = await storage.read(
          key: 'currentUser',
        );
        if (data == null)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(child: Text('Please Login first')),
          ));
        else {
          testData.testDataType=fileType==CustomFileType.image?TestDataType.Image:TestDataType.PDF;
          testData.creationDate=DateTime.now().toString();
          User admin = User.fromJson(json.decode(data ?? ''));
          testData.creator = admin;
          await ref
              .read(fileViewModelProvider.notifier).pushMedicalTestFile(file, widget.patient, fileType,testData,widget.medicalTests.testID??'');
        }
    }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sorry this file is un supported "),));
      }

      // print('file${result.files.single.path?.lastIndexOf('/')}');
    }
  }
  _reportDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              padding: const EdgeInsets.all(20),
              height: 180,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 60,
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        /*onSubmitted: (val) {
                      _addToDoItem(val);
                      _controller.clear();
                    },*/
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'إضافة تقرير',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        ),
                      )),
                  Container(
                    // height: 65,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: FilledButton(
                      child:
                      const Text('اضافة', style: TextStyle(fontSize: 18)),
                      onPressed: ()async {
                        FlutterSecureStorage storage = const FlutterSecureStorage();
                        String? data = await storage.read(
                          key: 'currentUser',
                        );
                        if (data == null)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(child: Text('Please Login first')),
                          ));
                        else {
                          testData.details=_controller.text;
                        testData.testDataType=TestDataType.Report;
                        testData.creationDate=DateTime.now().toString();
                          _controller.clear();
                          User admin = User.fromJson(json.decode(data ?? ''));
                          testData.creator = admin;
                        await ref
                            .read(fileViewModelProvider.notifier).postMedicalTestData( widget.patient,testData ,widget.medicalTests.testID??'');
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  Widget buildDoctorHeaderDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Images.profile,
                fit: BoxFit.fill,
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:  [
            Text("${"doctor".tr()}"": ${widget.medicalTests.creator?.name??''}",style: tsS12W500CkBlack,),
            Text("${"specialization".tr()}"":",style: tsS12W500CkBlack,),
          ],
        ),

      ],
    );
  }

  Widget buildDoctorFooterDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text("${"phone".tr()}"":${widget.medicalTests.creator?.phoneNumber??''}",style: tsS12W500CkBlack,),
        Text("${"adress".tr()}"":${widget.medicalTests.creator?.address?.city}-${widget.medicalTests.creator?.address?.governorate}-${widget.medicalTests.creator?.address?.country}",style: tsS12W500CkBlack,),
      ],
    );
  }
}



