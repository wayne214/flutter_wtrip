import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {

  @override
  void initState() {
    // TODO: implement initState
    _loadCityData();
    super.initState();
  }

  void _loadCityData() async{
    try{
      var value = await rootBundle.loadString('assets/data/cities.json');
      List list = json.decode(value);
//      list.forEach((value){
//
//      })
    }catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



}