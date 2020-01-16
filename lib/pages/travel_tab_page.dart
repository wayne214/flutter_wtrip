import 'package:flutter/material.dart';
import 'package:flutter_wtrip/dao/travel_page_dao.dart';
import 'package:flutter_wtrip/model/travel_page_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const DEFAULT_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  final String travelUrl;

  const TravelTabPage({Key key, this.groupChannelCode, this.travelUrl})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelPageItem> travelPageItems = [];
  int pageIndex = 1;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: travelPageItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => _TravelItem(
                index: index,
                item: travelPageItems[index],
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            )));
  }

  void _loadData() {
    TravelPageDao.fetch(widget.travelUrl ?? DEFAULT_URL,
            widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((TravelPageModel model) {
      setState(() {
        List<TravelPageItem> items = _filterItems(model.resultList);
        if (travelPageItems != null) {
          travelPageItems.addAll(items);
        } else {
          travelPageItems = items;
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  /// 过滤服务器返回结果， 移除article为空
  List<TravelPageItem> _filterItems(List<TravelPageItem> resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelPageItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });

    return filterItems;
  }
}

class _TravelItem extends StatelessWidget {
  final int index;
  final TravelPageItem item;

  const _TravelItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  _infoText() {
    return Text('');
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _poiName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }
}