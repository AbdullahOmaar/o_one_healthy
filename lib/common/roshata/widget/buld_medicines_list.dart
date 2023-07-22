import 'package:app/util/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MedicinesElement {
  String name;
  bool? isChecked;
  final DateTime timeOfCreation;

  MedicinesElement(this.name, this.isChecked, this.timeOfCreation);
}

class BuildMedicinesList extends StatefulWidget {
  const BuildMedicinesList({super.key});

  @override
  createState() => MyAppState();
}

class MyAppState extends State<BuildMedicinesList> {
  final List<MedicinesElement> _medicinesItems = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  void _addToDoItem(String text, isChecked) {
    if (text.isNotEmpty) {
      setState(() {
        _medicinesItems.add(MedicinesElement(text, isChecked, DateTime.now()));
      });
    }
  }

  void _editItem(String newText, int index) {
    setState(() {
      _medicinesItems[index].name = newText;
    });
  }

  void _editIsCheckedItem(int index, bool isChecked) {
    setState(() {
      _medicinesItems[index].isChecked = isChecked;
    });
    print(_medicinesItems[index].isChecked);
  }

  void _removeTodoItem(int index) {
    setState(() => _medicinesItems.removeAt(index));
  }

  _editDialog(BuildContext context, int index) {
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
                          hintText: 'تعديل الدواد ...',
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
                        _editItem(_controller.text, index);
                        _controller.clear();
                        Navigator.pop(context);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildMedicineItem(String text, isChecked, int index) {
    return SizedBox(
      child: Container(
        height: 58,
        margin: const EdgeInsets.only(
          left: 22.0,
          right: 22.0,
          bottom: 12,
        ),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(width: .0, color: Colors.lightBlue.shade900),
        //   ),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              checkColor:ThemeColors.kLightBlue ,
              activeColor: ThemeColors.kPrimary,
              value: isChecked,
              onChanged: (bool? value) {
                _editIsCheckedItem(index, value!);
              },
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  text,
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
              onPressed: () => _removeTodoItem(index),
            ),
          ],
        ),
      ),
    );
  }

  int compareElement(MedicinesElement a, MedicinesElement b) =>
      a.timeOfCreation.isAfter(b.timeOfCreation) ? -1 : 1;

  Widget _buildList() {
    _medicinesItems.sort(compareElement);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: _medicinesItems.length,
        itemBuilder: (context, index) {
          if (index < _medicinesItems.length) {
            return _buildMedicineItem(_medicinesItems[index].name,
                _medicinesItems[index].isChecked, index);
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
