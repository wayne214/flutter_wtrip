import 'package:flutter_wtrip/model/travel_page_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // 异步编程 Future
import 'dart:convert'; // http.Response 转换

const TRAVEL_PAGE_DEFAULT_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
// 固定参数,如果要被修改，不要定义成const
var Params = {
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
  "head": {},
  "contentType": "json"
};

class TravelPageDao {
  static Future<TravelPageModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    // 可变参数
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;
    var response = await http.post(TRAVEL_PAGE_DEFAULT_URL, body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelPageModel.fromJson(result); // 转换成HomeModel
    } else {
      throw Exception('Failed to load travel page json');
    }
  }
}
