import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com','m.ctrip.com/html5/','m.ctrip.com/html5','https://m.ctrip.com/webapp'];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid; // 禁止返回



  WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChangeListener;
  StreamSubscription<WebViewStateChanged> _onStateChangeListener;

  bool exiting = false;

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
          if(_isToMain(state.url) && !exiting) {
            if(widget.backForbid) {
              flutterWebviewPlugin.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
  }

  _isToMain(String url){
    bool contain = false;
    for(final value in CATCH_URLS) {
      if(url?.endsWith(value)??false) {
        contain = true;
        break;
      }
    }

    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChangeListener.cancel();
    _onStateChangeListener.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
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
          _appBar(Color(int.parse('0xff'+statusBarColor)), backButtonColor), // 将字符串颜色转成16进制颜色
          Expanded(
            child: WebviewScaffold(url: widget.url,
            withZoom: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Padding(padding: const EdgeInsets.only(top: 20.0),
                        child: new Text(
                          '加载中',
                          style: new TextStyle(fontSize: 12.0, color: Colors.lightBlue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if(widget.hideAppBar??false) {
      return Container(
        height: 30,
        color: backgroundColor,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        child: FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
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
