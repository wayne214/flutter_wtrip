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
  // 使用命名路由进行跳转
  static pushNamed(BuildContext context, String routeName) async {
    final result = await Navigator.pushNamed(context, routeName);
    return result;
  }
  // 返回上一页
  static pop(BuildContext context) {
     Navigator.pop(context);
  }
}
