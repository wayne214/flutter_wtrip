import 'package:flutter_wtrip/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // 异步编程 Future
import 'dart:convert'; // http.Response 转换

class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      // 只有当当前输入的内容和服务器返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model; // 转换成HomeModel
    } else {
      throw Exception('Failed to load search_page json');
    }
  }
}