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
      ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      body: widget.url.isNotEmpty
          ? WebViewWidget(
              controller: controller,
            )
          : const Center(
              child: Text('sorry , invalid data'),
            ),
    );
  }
}
