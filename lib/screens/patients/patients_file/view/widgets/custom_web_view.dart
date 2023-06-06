import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewer extends StatefulWidget {
  final String url;

  const CustomWebViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<CustomWebViewer> createState() => _CustomWebViewerState();
}

class _CustomWebViewerState extends State<CustomWebViewer> {
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
      ..loadRequest(Uri.parse(widget.url),headers: {
       /* "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "responseHeader": "Content-Type",
        "origin": "*",
        "maxAgeSeconds": "3600",
        "Access-Control-Allow-Methods": "POST,OPTIONS,GET,HEAD"*/
      });

    return Scaffold(
      body: widget.url.isNotEmpty
          ? SafeArea(
            child: WebViewWidget(
                controller: controller,
              ),
          )
          : const Center(
              child: Text('sorry , invalid data'),
            ),
    );
  }
}
