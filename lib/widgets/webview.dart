import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChangeListener;
  StreamSubscription<WebViewStateChanged> _onStateChangeListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
    _onUrlChangeListener =
        flutterWebviewPlugin.onUrlChanged.listen((String url) {});
    _onStateChangeListener =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUrlChangeListener.cancel();
    _onStateChangeListener.cancel();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String statusBarColor = widget.statusBarColor ?? 'ffffff';
    // TODO: implement build
    Color backButtonColor;
    if(statusBarColor == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColor)), backButtonColor), // 将字符串转成颜色
          Expanded(
            child: WebviewScaffold(url: null),
          )
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    return Container(
        child: FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.close,
                color: backButtonColor,
                size: 26,
              ),
            ),
          ),
          Positioned(
            left: 0,
              right: 0,
              child: Center(
            child: Text(
              widget.title ?? "",
              style: TextStyle(color: backButtonColor, fontSize: 20),
            ),
          ))
        ],
      ),
    ));
  }
}
