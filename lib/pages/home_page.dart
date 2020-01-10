import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wtrip/dao/home_dao.dart';
import 'package:flutter_wtrip/model/common_model.dart';
import 'package:flutter_wtrip/model/gridNav_model.dart';
import 'dart:convert';

import 'package:flutter_wtrip/model/home_model.dart';
import 'package:flutter_wtrip/widgets/grid_nav.dart';
import 'package:flutter_wtrip/widgets/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://pages.c-ctrip.com/commerce/promote/car/app/201908/pc/images/image1.png',
    'https://pages.c-ctrip.com/hotel/201908/fengyeji/fengyejiPC.jpg',
    'https://dimg04.c-ctrip.com/images/3009180000013phufC273.jpg'
  ];

  double appBarAlpha = 0;

  String resultString = '';

  List<CommonModel> localNavList = [];

  GridNavModel gridNavModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
//    HomeDao.fetch().then((result){
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e){
//      setState(() {
//        resultString = json.encode(e);
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
      });
    } catch (e) {
      print(e);
    }
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
                // 去除手机顶部的padding
                removeTop: true,
                context: context,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      // 滑动滚动是第0个元素，也就是列表滚动的时候才监听
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return true;
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 160,
                        child: Swiper(
                          itemCount: 3,
                          autoplay: true, // 自动播放
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(), // 指示器
                        ),
                      ),
                      Padding(
                        child: LocalNav(
                          localNavList: localNavList,
                        ),
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      ),
                      Padding(
                        child: GridNav(
                          gridNavModel: gridNavModel,
                        ),
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text(resultString),
                        ),
                      )
                    ],
                  ),
                )),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('首页'),
                    ),
                  )),
            )
          ],
        ));
  }
}
