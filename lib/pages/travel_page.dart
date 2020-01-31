import 'package:flutter/material.dart';
import 'package:flutter_wtrip/dao/travel_tab_dao.dart';
import 'package:flutter_wtrip/model/travel_tab_model.dart';
import 'package:flutter_wtrip/pages/travel_tab_page.dart';

const DEFAULT_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _tabController;
  TravelTabModel travelTabModel;
  List<TravelTab> tabs = [];

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      // 重新设置coller 修复标签不显示
      _tabController = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList(), //  将map装换成list
            ),
          ),
          Flexible(
              child: TabBarView(
                controller: _tabController,
                  children: tabs.map((TravelTab tab) {
            return TravelTabPage(travelUrl: travelTabModel.url, groupChannelCode: tab.groupChannelCode,);
          }).toList()))
        ],
      ),
    );
  }
}
