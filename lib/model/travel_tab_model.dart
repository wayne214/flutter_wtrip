
/// 旅拍模块顶部tab model
class TravelTabModel {
  String url;
  List<Tabs> tabs;

  TravelTabModel({this.url, this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['tabs'] != null) {
      tabs = new List<Tabs>();
      json['tabs'].forEach((v) {
        tabs.add(new Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Tabs {
  String labelName;
  String groupChannelCode;

  Tabs({this.labelName, this.groupChannelCode});

  Tabs.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}