import 'package:flutter/material.dart';
import 'package:flutter_wtrip/widgets/search_bar.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            hint: "11",
            defaultText: "哈哈哈",
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChange: _onChangeText,
            searchBarType: SearchBarType.normal,
          ),
        ],
      ),
    );
  }

  _onChangeText(text){

  }

}