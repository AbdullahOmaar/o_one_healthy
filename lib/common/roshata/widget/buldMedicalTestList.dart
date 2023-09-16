import 'package:app/util/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/patients/patients_file/patient_file_view_model/patients_file_view_model.dart';
import '../../../screens/patients/patients_files_search/models/patient_model.dart';
import '../../../util/theme/styles.dart';


class BuildTestsList extends ConsumerStatefulWidget {
  Patient patient;
  final bool isNewMedicalTests;

  MedicalTests medicalTests;
  Function(List<Test>)? onTestUpdate;
  BuildTestsList({super.key,required this.medicalTests,required this.isNewMedicalTests,required this.patient,this.onTestUpdate});

  @override
  ConsumerState<BuildTestsList>  createState() => MyAppState();
}

class MyAppState extends ConsumerState<BuildTestsList> {
   List<Test> _testsItems = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  @override
  void initState() {
    _testsItems=widget.medicalTests.test??[];
    super.initState();
  }

   @override
  void didUpdateWidget(BuildTestsList oldWidget) {
     _testsItems=widget.medicalTests.test??[];
     super.didUpdateWidget(oldWidget);
  }

  void _addToDoItem(String testName, isChecked) async{

    String testKey ;
    do{
      testKey = RandomPasswordGenerator()
          .randomPassword(
          letters: false,
          numbers: true,
          passwordLength: 2,
          specialChar: false,
          uppercase: false)
          .toString();
    }while(_testsItems.contains(testKey));
    if (testName.isNotEmpty) {
      Test test=Test(testName: testName,key: testKey);
      setState(() {
        // widget.patient
        _testsItems.add(test);
        // widget.medicalTests.tests?.add(Test(testName: text));
        if(widget.onTestUpdate!=null)
          widget.onTestUpdate!(_testsItems);
        // _testsItems.add(TestsElement(text, isChecked, DateTime.now()));
      });
/*
      if(!widget.isNewMedicalTests)
        await ref
            .read(fileViewModelProvider.notifier).updateTest( widget.patient, widget.medicalTests,test,true);
*/

    }
  }

  void _editItem(String newText, int testIndex)async {
    _testsItems[testIndex].testName=newText;
    setState(() {

    });
  /*  if(!widget.isNewMedicalTests)
    await ref
        .read(fileViewModelProvider.notifier).updateTest( widget.patient, widget.medicalTests,_testsItems[testIndex],false);*/
  }


  _editDialog(BuildContext context, int testIndex) {
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
                          hintText: 'تعديل الدواء ...',
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
                          const Text('تعديل', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        _editItem(_controller.text, testIndex);
                        _controller.clear();
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
  Widget _buildTestItem(Test test, /*isChecked,*/ int index) {
    return SizedBox(
      child: Container(
        height: 58,
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
                  test.testName??'',
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () => null,
              ),
            ),
      /*      IconButton(
              icon:  Icon(
                Icons.edit,
                color:ThemeColors.kPrimary,
              ),
              onPressed: () => _editDialog(context, index),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: ()async {
                showDialog(
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
                              Text(
                                "Are you sure you want to delete this item ?",
                              ),
                              Row(
                                children: [
                                  buildDeleteDialogButtons("Yes",Colors.red,() async{

                                    *//*         if(!widget.isNewMedicalTests) {
                                      await ref
                                          .read(fileViewModelProvider.notifier)
                                          .deleteTest(
                                              widget.patient,
                                              widget.medicalTests,
                                              test.key ?? '');
                                    }

                                    *//*

                                    _testsItems.remove(test);
                                    setState(() {
                                    });
                                    Navigator.of(context).pop();
                                  }),
                                  Spacer(),
                                  buildDeleteDialogButtons("No",ThemeColors.kPrimary,() async{
                                    Navigator.of(context).pop();
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });

              },
            ),*/
          ],
        ),
      ),
    );
  }

/*  int compareElement(Test a, Test b) =>
      a.testName.isAfter(b.testName) ? -1 : 1;*/

  Widget _buildList() {
    // _testsItems.sort(compareElement);
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: false,
        itemCount: _testsItems.length,
        itemBuilder: (context, index) {
          if (index < _testsItems.length) {
            return _testsItems[index].testName=="undefined" ?SizedBox():_buildTestItem(_testsItems[index]
                /*_testsItems[index].isChecked*/, index);
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
        if(widget.isNewMedicalTests)
        Container(
          height: 40,
          margin: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: SizedBox(
                  // height: double.infinity,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _controller1,
                    autofocus: true,
                    onSubmitted: (val) {
                      _addToDoItem(val, false);
                      _controller1.clear();
                    },
                    // style: const TextStyle(
                    //   fontSize: 15,
                    // ),
                    decoration: InputDecoration(
                      hintText: "patients.add_test".tr(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide:
                            BorderSide(color: ThemeColors.kPrimary, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: double.infinity,
                  margin: const EdgeInsets.only(left: 12, right: 10),
                  child: FilledButton(
                    child: Icon(
                      Icons.add,
                      color: ThemeColors.kLightBlue,
                    ),
                    onPressed: () {
                      _addToDoItem(_controller1.text, false);
                      _controller1.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildList()
      ]),
    );
  }
}
