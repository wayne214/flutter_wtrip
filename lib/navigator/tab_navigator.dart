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
          _tabBarItem(Icons.home, '首页', 0),
          _tabBarItem(Icons.search, '搜索', 1),
          _tabBarItem(Icons.camera_alt, '旅拍', 2),
          _tabBarItem(Icons.account_circle, "我的", 3),
        ],
        currentIndex: _currentIndex,
//        selectedItemColor: _activeColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // 固定显示
      ),
    );
  }

  _tabBarItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(title,
            style: TextStyle(
                color:
                _currentIndex != index ? _defaultColor : _activeColor)));
  }
}
