import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// 加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover? !isLoading ? child : _loadingView :
    Stack(
      children: <Widget>[
        child, isLoading? _loadingView : null
      ],
    );
  }

  Widget get _loadingView{
    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          new CircularProgressIndicator(),
          new SpinKitPumpingHeart(color: Colors.blue,),
          new Padding(padding: const EdgeInsets.only(top: 20.0),
            child: new Text(
              '拼命加载中...',
              style: new TextStyle(fontSize: 12.0, color: Colors.lightBlue),
            ),
          )
        ],
      ),
    );
  }
}
