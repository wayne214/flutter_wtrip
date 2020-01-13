import 'package:flutter/material.dart';
import 'package:flutter_wtrip/pages/home_page.dart';
import 'package:flutter_wtrip/pages/my_page.dart';
import 'package:flutter_wtrip/pages/search_page.dart';
import 'package:flutter_wtrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  void _onItemTapped(int value) {
    _controller.jumpToPage(value);
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex != 0 ? _defaultColor : _activeColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.search,
                color: _activeColor,
              ),
              title: Text('搜索',
                  style: TextStyle(
                      color:
                          _currentIndex != 1 ? _defaultColor : _activeColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.camera_alt,
                color: _activeColor,
              ),
              title: Text('旅拍',
                  style: TextStyle(
                      color:
                          _currentIndex != 2 ? _defaultColor : _activeColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: _activeColor,
              ),
              title: Text('我的',
                  style: TextStyle(
                      color:
                          _currentIndex != 3 ? _defaultColor : _activeColor))),
        ],
        currentIndex: _currentIndex,
//        selectedItemColor: _activeColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // 固定显示
      ),
    );
  }
}
