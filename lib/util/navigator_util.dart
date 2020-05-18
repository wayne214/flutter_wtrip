import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// 页面跳转工具类
class NavigatorUtil {
  // 跳转页面
  static push(BuildContext context, Widget page) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
    return result;
  }
}
