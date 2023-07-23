import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../native_widget.dart';
import '../../patient_file_repository/patients_files_repository.dart';

class CustomWebViewer extends StatefulWidget {
  final String url;
  final FileType fileType;
  final String dicomFileLocalPath;


  const CustomWebViewer({Key? key, required this.url,required this.fileType,required this.dicomFileLocalPath}) : super(key: key);

  @override
  State<CustomWebViewer> createState() => _CustomWebViewerState();
}

class _CustomWebViewerState extends State<CustomWebViewer> {
  getNativeDicomImage()=>  Container(
      color: Colors.black,
      width: 500,
      height: 900,
      child:
      NativeWidget(url: widget.dicomFileLocalPath));
  @override
  Widget build(BuildContext context) {

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    return Scaffold(
      body: widget.url.isNotEmpty
          ? SafeArea(
            child: widget.fileType==FileType.pdf?
            SfPdfViewer.network(
                widget.url)
            :widget.fileType==FileType.dicom ?
            getNativeDicomImage():
            WebViewWidget(
                controller: controller,
              ),
          )
          : const Center(
              child: Text('sorry , invalid data'),
            ),
    );

  }
}
