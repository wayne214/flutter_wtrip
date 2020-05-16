import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wtrip/widgets/loading_container.dart';
import 'package:azlistview/azlistview.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  bool _loading = true; //页面加载状态

  List<CityInfo> _cityList = List();

  @override
  void initState() {
    // TODO: implement initState
    _loadCityData();
    super.initState();
  }

  void _loadCityData() async {
    try {
      var value = await rootBundle.loadString('assets/data/cities.json');
      List list = json.decode(value);
//      list.forEach((value){
//
//      })
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('选择城市'),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text('定位城市'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.place, size: 20.0,),
                  Text('北京市')
                ],
              ),
            ),
            Divider(height: .0,),
//            Expanded(
//              flex: 1,
//              child: AzListView(
//                data: _cityList,
//                itemBuilder: (context, model) => _bu,
//              ),
//            )
          ],
        ),
      ),
    );
  }
}

class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
