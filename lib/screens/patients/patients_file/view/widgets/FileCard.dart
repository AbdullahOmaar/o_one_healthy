import 'package:app/screens/patients/patients_file/view/widgets/custom_web_view.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../patient_file_repository/patients_files_repository.dart';

class FileCard extends StatefulWidget {
  final FileType fileType;
  final Patient patient;
  final int index;

  const FileCard({
    Key? key,
    required this.fileType,
    required this.patient,
    required this.index,
  }) : super(key: key);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  String? url;
  String dicomFileLocalPath ='';

  IconData getIconFromFileType() {
    switch (widget.fileType) {
      case FileType.image:
        url = widget.patient.medicalRecord?.patientRays
            ?.imageRays![widget.index].imageFile;
        return Icons.image;
      case FileType.dicom:
        url = widget.patient.medicalRecord?.patientRays
            ?.dicomRays![widget.index].dicomFile;
        return Icons.medical_information;
      case FileType.pdf:
        url = widget
            .patient.medicalRecord?.patientRays?.pdfRays![widget.index].pdfFile;
        return Icons.picture_as_pdf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .30,
      child: Card(
        elevation: 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                getIconFromFileType(),
                size: MediaQuery.of(context).size.width * .20,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CustomWebViewer(dicomFileLocalPath:url??'',url: widget.fileType ==FileType.dicom?"https://webnamics.github.io/u-dicom-viewer/":url ?? '',fileType: widget.fileType)));

                      // if(widget.fileType ==FileType.dicom) {
                      /*  FileDownloader.downloadFile(url: url??'',onDownloadCompleted: (value){
                          dicomFileLocalPath=value;
                        }).then((value) async{

                        });*/
                     // }
               /*       await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CustomWebViewer(dicomFileLocalPath:dicomFileLocalPath,url: widget.fileType ==FileType.dicom?"https://webnamics.github.io/u-dicom-viewer/":url ?? '',fileType: widget.fileType)));
                 */   },
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: MediaQuery.of(context).size.width * .07,
                      color: Colors.indigo,
                    )),
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData( ClipboardData(text: url??''));
                      print(url);
                    },
                    icon: Icon(
                      Icons.copy,
                      size: MediaQuery.of(context).size.width * .07,
                      color: Colors.indigo,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
