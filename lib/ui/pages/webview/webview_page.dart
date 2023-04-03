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
          initialUrl: 'https://www.google.com/maps/@-5.474367,105.3147636,16z',
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
        /*Visibility(
          visible: isLoading,
          child: const Center(),
        )*/
      ],
    );
  }
}
