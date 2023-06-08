import 'dart:io';
import 'package:app/common/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../patients_files_search/models/patient_model.dart';
import '../../../patients_files_search/view_model/patients_files_search_view_model.dart';
import '../../patient_file_repository/patients_files_repository.dart' as repo;
import '../../patient_file_view_model/patients_file_view_model.dart';
import 'FileCard.dart';

class RaysScreen extends ConsumerStatefulWidget {
   Patient patient;

   RaysScreen({Key? key, required this.patient}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RaysScreenState();
}

class _RaysScreenState extends ConsumerState<RaysScreen> {
  int listCount = 0;
  List<PatientFile>? files;

  @override
  void initState() {
    getCurrentPatient();
    super.initState();
  }
  @override
  void didUpdateWidget(RaysScreen oldWidget) {
    getCurrentPatient();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.patient= ref.watch(fileViewModelProvider).currentPatient??widget.patient;
    fetchPatientData();
    return RefreshIndicator(
      onRefresh: () {
        getCurrentPatient();

        return Future(() => null);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:!(ref.watch(fileViewModelProvider).isPushLoading??false)? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      text: "add pdf",
                      fontSize: 16,
                      onPressed: () async {
                        filePickAction(repo.FileType.pdf);
                      },
                      btnWidth: CustomWidth.oneThird),
                  CustomButton(
                      text: "add Dicom",
                      fontSize: 16,
                      onPressed: () async {
                        filePickAction(repo.FileType.dicom);
                      },
                      btnWidth: CustomWidth.oneThird),
                  CustomButton(
                      text: "add image ",
                      fontSize: 16,
                      onPressed: () async {
                        filePickAction(repo.FileType.image);
                      },
                      btnWidth: CustomWidth.oneThird),
                ],
              ),
            ),
            getFileHeaderWithSpacer('pdf files'),
            getFileList(repo.FileType.pdf),
            getFileHeaderWithSpacer('image files'),
            getFileList(repo.FileType.image),
            getFileHeaderWithSpacer('dicom files'),
            getFileList(repo.FileType.dicom)
          ],
        ):const Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  Widget getFileHeaderWithSpacer(String header) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .95,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              header,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black38,
          )
        ],
      ),
    );
  }

  Widget getFileList(repo.FileType fileType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .20,
        child: ListView.builder(
          itemCount: getFilesListCount(fileType),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return FileCard(
              fileType: fileType,
              patient: widget.patient,
              index: index,
            );
          },
        ),
      ),
    );
  }

  int getFilesListCount(repo.FileType fileType) {
    switch (fileType) {
      case repo.FileType.image:
        return widget.patient.medicalRecord?.patientRays?.imageRays?.length ??
            0;
      case repo.FileType.dicom:
        return widget.patient.medicalRecord?.patientRays?.dicomRays?.length ??
            0;
      case repo.FileType.pdf:
        return widget.patient.medicalRecord?.patientRays?.pdfRays?.length ?? 0;
    }
  }

  void filePickAction(repo.FileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String fileName =
          Uri.file(result.files.single.path ?? '').pathSegments.last;
      if (fileName.substring(fileName.lastIndexOf('.')).contains('pdf') ||
          fileName.substring(fileName.lastIndexOf('.')).contains('jpg') ||
          fileName.substring(fileName.lastIndexOf('.')).contains('png')||
          fileName.substring(fileName.lastIndexOf('.')).contains('DCM')||
          fileName.substring(fileName.lastIndexOf('.')).contains('zip')) {
        await ref
            .read(fileViewModelProvider.notifier)
            .pushPatientFile(file, widget.patient, fileType);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("sorry this file is un supported "),));
      }

      // print('file${result.files.single.path?.lastIndexOf('/')}');
    }
  }
  fetchPatientData() async {
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
    if( ref.watch(fileViewModelProvider).isPushLoading??false) {
      ref
          .read(fileViewModelProvider.notifier)
          .getPatientData(widget.patient);
    }
  }
  getCurrentPatient(){
    ref
        .read(fileViewModelProvider.notifier)
        .getPatientData(widget.patient);
  }
}
