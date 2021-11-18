import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterminiprogram/utils/jsEnv.dart';
import 'package:flutterminiprogram/utils/server.dart';
import 'package:flutterminiprogram/utils/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServerAndView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ServerAndViewState();
  }
}

class ServerAndViewState extends State<ServerAndView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    FmServer.closeServer();
    super.dispose();
  }

  void _init () async {
    // FmServer.createServer();

    JsEnv.create(
      /// 监听JS传递过来的信息
      subscribeEvent: ((message) {
        String commend = 'callJS("$message")';
        _webViewController.evaluateJavascript(commend);
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server Page'),
      ),
      body: FmWebview(
        initialUrl: 'http://localhost:8000',
        onWebviewChange: (WebViewController webviewController) {
          _webViewController = webviewController;
        }
      )
    );
  }
}
