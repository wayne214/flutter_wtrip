import 'package:flutter/material.dart';
import 'package:flutter_wtrip/model/common_model.dart';
import 'package:flutter_wtrip/model/gridNav_model.dart';
import 'package:flutter_wtrip/widgets/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel(
      color: Colors.transparent,// 透明
      borderRadius: BorderRadius.circular(6), // 圆角
      clipBehavior: Clip.antiAlias, // 裁切
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    // 整个卡片
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context,gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context,gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context,gridNavModel.travel, false));
    }

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem item, bool isFirst) {
    // 卡片的三块
    List<Widget> items = [];
    items.add(_mainItem(context, item.mainItem));
    items.add(_doubleItem(context, item.item1, item.item2));
    items.add(_doubleItem(context, item.item3, item.item4));

    List<Widget> expandItems = [];
    items.forEach((item){
      expandItems.add(Expanded(child: item, flex: 1,));
    });

    Color startColor = Color(int.parse('0xff'+item.startColor));
    Color endColor = Color(int.parse('0xff'+item.endColor));

    return Container(
      height: 88,
      margin: isFirst? null: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 颜色渐变
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(context, Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image.network(
          model.icon,
          fit: BoxFit.contain,
          width: 88,
          height: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
          margin: EdgeInsets.only(top: 11),
          child: Text(
            model.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      ],
    ), model);
  }

  _doubleItem(BuildContext context, CommonModel topModel,
      CommonModel bottomModel) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topModel, true),
        ),
        Expanded(
          child: _item(context, bottomModel, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      // 撑满父布局
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: isFirst ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(context, Center(
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ), item)
      ),
    );
  }
  // 封装点击跳转逻辑
  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      child: widget,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>(
            WebView(url: model.url, statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        )));
      },
    );
  }
}
