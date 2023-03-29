import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = false;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'https://www.google.com/maps/@-6.1169244,105.4333728,12z',
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: ((url) {
            setState(() {
              isLoading = false;
            });
          }),
        ),
      ],
    );
  }
}
