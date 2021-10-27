import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  String title = "";
  String url="";
  late WebViewController webviewController;

  @override
  void initState() {
    super.initState();
    final map = Get.arguments as Map;
    url=map["url"];
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: WebView(
        initialUrl: url,
        onWebViewCreated: (controller) {
          webviewController = controller;
        },
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          print("loadfinis:$url");
          webviewController.evaluateJavascript("document.title").then((result) {
            setState(() {
              title = result;
            });
          });
        },
          navigationDelegate: (NavigationRequest request){
          String tUrl=request.url;
          print("requestUrl:::>>>>${tUrl}");
          return NavigationDecision.navigate;
          }
      ),
    );
  }
}
