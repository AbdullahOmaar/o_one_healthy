import 'package:app/util/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:sizer/sizer.dart';

import '../../../screens/patients/patients_file/patient_file_view_model/patients_file_view_model.dart';
import '../../../screens/patients/patients_files_search/models/patient_model.dart';
import '../../../util/theme/styles.dart';

class MedicinesElement {
  String name;
  bool? isChecked;
  final DateTime timeOfCreation;

  MedicinesElement(this.name, this.isChecked, this.timeOfCreation);
}

class BuildMedicinesList extends ConsumerStatefulWidget {
  Patient patient;
  final bool isNewPrescription;

  Prescription prescription;
  Function(List<Medicine>)? onMedicineUpdate;
  BuildMedicinesList({super.key,required this.prescription,required this.isNewPrescription,required this.patient,this.onMedicineUpdate});

  @override
  ConsumerState<BuildMedicinesList>  createState() => MyAppState();
}

class MyAppState extends ConsumerState<BuildMedicinesList> {
   List<Medicine> _medicinesItems = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  @override
  void initState() {
    _medicinesItems=widget.prescription.medicines??[];
    super.initState();
  }

   @override
  void didUpdateWidget(BuildMedicinesList oldWidget) {
     _medicinesItems=widget.prescription.medicines??[];
     super.didUpdateWidget(oldWidget);
  }

  void _addToDoItem(String medicineName, isChecked) async{

    String medicineKey ;
    do{
      medicineKey = RandomPasswordGenerator()
          .randomPassword(
          letters: false,
          numbers: true,
          passwordLength: 2,
          specialChar: false,
          uppercase: false)
          .toString();
    }while(_medicinesItems.contains(medicineKey));
    if (medicineName.isNotEmpty) {
      Medicine medicine=Medicine(medicineName: medicineName,key: medicineKey);
      setState(() {
        // widget.patient
        _medicinesItems.add(medicine);
        // widget.prescription.medicines?.add(Medicine(medicineName: text));
        if(widget.onMedicineUpdate!=null)
          widget.onMedicineUpdate!(_medicinesItems);
        // _medicinesItems.add(MedicinesElement(text, isChecked, DateTime.now()));
      });
      if(!widget.isNewPrescription)
        await ref
            .read(fileViewModelProvider.notifier).updateMedicine( widget.patient, widget.prescription,medicine,true);

    }
  }

  void _editItem(String newText, int medicineIndex)async {
    _medicinesItems[medicineIndex].medicineName=newText;
    if(!widget.isNewPrescription)
    await ref
        .read(fileViewModelProvider.notifier).updateMedicine( widget.patient, widget.prescription,_medicinesItems[medicineIndex],false);
  }

/*  void _editIsCheckedItem(int index, bool isChecked) {
    setState(() {
      _medicinesItems[index].isChecked = isChecked;
    });
    print(_medicinesItems[index].isChecked);
  }*/

/*  void _removeTodoItem(int index) {
    setState(() => _medicinesItems.removeAt(index));
  }*/

  _editDialog(BuildContext context, int medicineIndex) {
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
                        _editItem(_controller.text, medicineIndex);
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
  Widget _buildMedicineItem(Medicine medicine, /*isChecked,*/ int index) {
    return SizedBox(
      child: Container(
        height: 58,
        margin: const EdgeInsets.only(
          left: 22.0,
          right: 22.0,
          bottom: 0,
        ),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(width: .0, color: Colors.lightBlue.shade900),
        //   ),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
       /*     Checkbox(
              checkColor:ThemeColors.kLightBlue ,
              activeColor: ThemeColors.kPrimary,
              value: isChecked,
              onChanged: (bool? value) {
                // _editIsCheckedItem(index, value!);
              },
            ),*/
            Expanded(
              child: ListTile(
                title: Text(
                  medicine.medicineName??'',
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () => null,
              ),
            ),
            IconButton(
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
                                    if(!widget.isNewPrescription)
                                      await ref
                                        .read(fileViewModelProvider.notifier).deleteMedicine( widget.patient, widget.prescription,medicine.key??'');
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
            ),
          ],
        ),
      ),
    );
  }

/*  int compareElement(Medicine a, Medicine b) =>
      a.medicineName.isAfter(b.medicineName) ? -1 : 1;*/

  Widget _buildList() {
    // _medicinesItems.sort(compareElement);
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: false,
        itemCount: _medicinesItems.length,
        itemBuilder: (context, index) {
          if (index < _medicinesItems.length) {
            return _medicinesItems[index].medicineName=="undefined" ?SizedBox():_buildMedicineItem(_medicinesItems[index]
                /*_medicinesItems[index].isChecked*/, index);
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
                      hintText: "patients.add_medicine".tr(),
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
