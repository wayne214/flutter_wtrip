import 'package:flutter/material.dart';
import 'package:flutter_wtrip/dao/search_dao.dart';
import 'package:flutter_wtrip/model/search_model.dart';
import 'package:flutter_wtrip/widgets/search_bar.dart';
import 'package:flutter_wtrip/widgets/webview.dart';

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
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      })))
        ],
      ),
    );
  }

  // 搜索结果item
  _item(int pos) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[pos];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (WebView(
                      url: item.url,
                      title: '详情',
                    ))));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 300,
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: ' ' + (item.districtname??'') + ' ' +(item.zonename??''),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        )));

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }

  _subTitle(SearchItem item) {
    if (item == null) return null;
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: item.price??"",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
          TextSpan(
            text: " " + (item.star??""),
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ]
      ),
    );
  }
  // 富文本文字高亮
  _keywordTextSpans(String word, String keyword) {
    if (word == null || word.length == 0) return null;
    List<TextSpan> spans = [];
    List<String> arr = word.split(keyword);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(
            text: keyword,
            style: TextStyle(color: Colors.orange, fontSize: 16)));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(
            text: val, style: TextStyle(color: Colors.black87, fontSize: 16)));
      }
    }
    return spans;
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
      if (modal.keyword == keyWord) {
        setState(() {
          searchModel = modal;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }
}
