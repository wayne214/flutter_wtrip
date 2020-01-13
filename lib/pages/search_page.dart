import 'package:flutter/material.dart';
import 'package:flutter_wtrip/dao/search_dao.dart';
import 'package:flutter_wtrip/model/search_model.dart';
import 'package:flutter_wtrip/widgets/search_bar.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyWord;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl = URL, this.keyWord, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyWord;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(context),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length??0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      })))
        ],
      ),
    );
  }

  _item(int pos) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[pos];
    return Text(item.word);
  }

  _appBar(BuildContext context) {
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
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              hint: widget.hint,
              defaultText: widget.keyWord,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChange: _onChangeText,
              searchBarType: SearchBarType.normal,
            ),
          ),
        )
      ],
    );
  }

  _onChangeText(String text) {
    keyWord = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }

    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((SearchModel modal) {
      if(modal.keyword == keyWord) {
        setState(() {
          searchModel = modal;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }
}
