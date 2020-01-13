import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wtrip/dao/home_dao.dart';
import 'package:flutter_wtrip/model/common_model.dart';
import 'package:flutter_wtrip/model/gridNav_model.dart';
import 'dart:convert';

import 'package:flutter_wtrip/model/home_model.dart';
import 'package:flutter_wtrip/model/sales_box_model.dart';
import 'package:flutter_wtrip/widgets/grid_nav.dart';
import 'package:flutter_wtrip/widgets/loading_container.dart';
import 'package:flutter_wtrip/widgets/local_nav.dart';
import 'package:flutter_wtrip/widgets/sales_box.dart';
import 'package:flutter_wtrip/widgets/search_bar.dart';
import 'package:flutter_wtrip/widgets/sub_nav.dart';
import 'package:flutter_wtrip/widgets/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  String resultString = '';

  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];

  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    print('调用了吗');
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
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }

    return null;
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
  // 跳转搜索页面
  _jumpToSearch() {

  }
  // 跳转语音页面
  _jumpToSpeak(){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
          isLoading: isLoading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                  // 去除手机顶部的padding
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: NotificationListener(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          // 滑动滚动是第0个元素，也就是列表滚动的时候才监听
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                        return true;
                      },
                      child: _listView,
                    ),
                  )),
              _appBar,
            ],
          )),
    );
  }
  // 顶部搜索框
  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
            ),
          ),
        ),
        // 底部阴影
        Container(
          height: appBarAlpha > 0.2 ? 0.5: 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true, // 自动播放
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (WebView(
                            url: bannerList[index].url,
                            statusBarColor: bannerList[index].statusBarColor,
                            hideAppBar: bannerList[index].hideAppBar,
                          ))));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(), // 指示器
      ),
    );
  }

  Widget get _listView {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _banner,
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
        Padding(
          child: SubNav(
            subNavList: subNavList,
          ),
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        ),
        Padding(
          child: SalesBox(
            salesBox: salesBoxModel,
          ),
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        ),
//                      Container(
//                        height: 800,
//                        child: ListTile(
//                          title: Text(resultString),
//                        ),
//                      )
      ],
    );
  }
}
