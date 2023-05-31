
import 'dart:io';
import 'package:app/common/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../patients_files_search/models/patient_model.dart';
import '../../patient_file_repository/patients_files_repository.dart'as repo;
import '../../patient_file_view_model/patients_file_view_model.dart';

class RaysScreen extends ConsumerStatefulWidget {
  final Patient patient ;
    const RaysScreen({Key? key,required this.patient}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RaysScreenState();
}

class _RaysScreenState extends ConsumerState<RaysScreen> {
  @override
  Widget build(BuildContext context) {
    print('${widget.patient.medicalRecord?.patientRays?.pdfRays?.length}');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(text: "add pdf", fontSize: 16, onPressed: ()async{
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              File file = File(result.files.single.path.toString());
              String fileName= Uri.file(result.files.single.path??'').pathSegments.last;
              await ref.read(fileViewModelProvider.notifier).pushPatientFile(file, widget.patient,repo.FileType.image);

              // print('file${result.files.single.path?.lastIndexOf('/')}');

            } else {
              // User canceled the picker
            }
          }, btnWidth: CustomWidth.oneThird),
        ],
      ),
    );
  }
}

