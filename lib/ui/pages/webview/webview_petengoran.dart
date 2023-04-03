import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPagePetengoran extends StatefulWidget {
  const WebViewPagePetengoran({Key? key}) : super(key: key);

  @override
  State<WebViewPagePetengoran> createState() => _WebViewPagePetengoranState();
}

class _WebViewPagePetengoranState extends State<WebViewPagePetengoran> {
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
          initialUrl: 'https://www.google.com/maps/@-5.5664595,105.2417529,17z',
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
