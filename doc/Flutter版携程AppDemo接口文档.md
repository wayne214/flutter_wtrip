- [接口地址](#接口地址)
- [接口字段](#接口字段)
- [HomeModel](#HomeModel)
- [CommonModel](#CommonModel)
- [GridNavModel](#GridNavModel)
- [SalesBoxModel](#SalesBoxModel)
- [ConfigModel](#ConfigModel)


## 接口地址

[http://www.devio.org/io/flutter_app/json/home_page.json](http://www.devio.org/io/flutter_app/json/home_page.json)

## 接口字段

[JSON在线解析](https://www.json.cn/)

## HomeModel

![home_page](http://www.devio.org/io/flutter_app/img/blog/home_page.png)

字段 | 类型 | 备注
| -------- | -------- | -------- |
config | Object	| NonNull
bannerList | Array	|	NonNull
localNavList | Array	|	NonNull
gridNav | Object	|	NonNull
subNavList | Array	|	NonNull
salesBox | Object	|	NonNull

## CommonModel

![common-model](http://www.devio.org/io/flutter_app/img/blog/common-model.png)

字段 | 类型 | 备注
| -------- | -------- | -------- |
icon | String	| Nullable
title | String	|	Nullable
url | String	|	NonNull
statusBarColor | String	|	Nullable
hideAppBar | bool	|	Nullable

## GridNavModel

![grid-nav](http://www.devio.org/io/flutter_app/img/blog/grid-nav.png)

字段 | 类型 | 备注
| -------- | -------- | -------- |
hotel | Object	| NonNull
flight | Object	|	NonNull
travel | Object	|	NonNull

## SalesBoxModel

![sales-box](http://www.devio.org/io/flutter_app/img/blog/sales-box.png)

字段 | 类型 | 备注
| -------- | -------- | -------- |
icon | String	| NonNull
moreUrl | String	|	NonNull
bigCard1 | Object	|	NonNull
bigCard2 | Object	|	NonNull
smallCard1 | Object	|	NonNull
smallCard2 | Object	|	NonNull
smallCard3 | Object	|	NonNull
smallCard4 | Object	|	NonNull

## ConfigModel

![config](http://www.devio.org/io/flutter_app/img/blog/config.png)

字段 | 类型 | 备注
| -------- | -------- | -------- |
searchUrl | String	| NonNull


## 搜索页接口
https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=1

## 旅拍接口
旅拍类别
[http://www.devio.org/io/flutter_app/json/travel_page.json](http://www.devio.org/io/flutter_app/json/travel_page.json)
旅拍页地址
https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5
```
"params": {
    "districtId": -1,
    "groupChannelCode": "tourphoto_global1",
    "type": null,
    "lat": -180,
    "lon": -180,
    "locatedDistrictId": 2,
    "pagePara": {
      "pageIndex": 1,
      "pageSize": 10,
      "sortType": 9,
      "sortDirection": 0
    },
    "imageCutType": 1,
    "head": {
      "cid": "09031014111431397988",
      "ctok": "",
      "cver": "1.0",
      "lang": "01",
      "sid": "8888",
      "syscode": "09",
      "auth": null,
      "extension": [
        {
          "name": "protocal",
          "value": "https"
        }
      ]
    },
    "contentType": "json"
  }
```