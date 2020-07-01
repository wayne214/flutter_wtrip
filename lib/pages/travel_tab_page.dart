import 'package:flutter/material.dart';
import 'package:flutter_wtrip/dao/travel_page_dao.dart';
import 'package:flutter_wtrip/model/travel_page_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wtrip/widgets/loading_container.dart';
import 'package:flutter_wtrip/widgets/webview.dart';

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

/// with AutomaticKeepAliveClientMixin 加载过的页面重绘
class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelPageItem> travelPageItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  bool showToTopBtn = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(isLoadMore: true);
      }
    });
    super.initState();
  }

  // 刷新是一个异步方法
  Future<Null> _handleRefresh() async {
    _loadData();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 4,
                  itemCount: travelPageItems?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) => _TravelItem(
                    index: index,
                    item: travelPageItems[index],
                  ),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                )),
            onRefresh: _handleRefresh),
      ),
      // 显示一个返回顶部按钮
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: Duration(microseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }

  /// Dart 可选参数
  void _loadData({isLoadMore = false}) async {
    if (isLoadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    try {
      TravelPageModel model = await TravelPageDao.fetch(
          widget.travelUrl ?? DEFAULT_URL,
          widget.groupChannelCode,
          pageIndex,
          PAGE_SIZE);
      _isLoading = false;

      setState(() {
        List<TravelPageItem> items = _filterItems(model.resultList);
        if (travelPageItems != null) {
          travelPageItems.addAll(items);
        } else {
          travelPageItems = items;
        }
      });
    } catch (e) {
      print(e);
      _isLoading = false;
    }
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _TravelItem extends StatelessWidget {
  final int index;
  final TravelPageItem item;

  const _TravelItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (WebView(
                      url: item.article.urls[0].h5Url,
                      title: '旅拍详情',
                    ))));
      },
      child: Card(
        /// 裁切圆角
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 设置子widget未知
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
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article.articleTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(item.article.likeCount.toString()),
              )
            ],
          )
        ],
      ),
    );
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
                  // 显示带缩略号的文字
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
