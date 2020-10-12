# flutter版高仿携程App

#### 这是一个Flutter版本的仿携程App的demo，相对完整的学习一个APP的开发过程，更加高效的进行学习Flutter开发

## 模块与特性
- 首页(已完成)
- 搜索(已完成部分，缺少语音搜索功能)
- 旅拍(瀑布流展示)
- 我的(Webview展示)
- 实现网络图片本地缓存
- 选择定位城市列表

## 项目中使用到第三方
 - cupertino_icons: ^0.1.2(图标库)
 - flutter_swiper: ^1.1.6（首页轮播图）
 - http: ^0.12.0+4（网络请求）
 - flutter_webview_plugin: ^0.3.10+1（webview插件）
 - flutter_staggered_grid_view: ^0.3.0（网格布局，旅拍模块）
 
 
## Flutter中常用第三方
- [cached_network_image](https://pub.dev/packages/cached_network_image) 图片缓存框架
- [http](https://pub.dev/packages/http) 网络请求框架
- [fluttertoast](https://pub.dev/packages/fluttertoast) 吐司提示框架
- [flutter_webview_plugin](https://pub.dev/packages/flutter_webview_plugin) webView框架
- [webview_flutter](https://pub.dev/packages/webview_flutter)WebView 组件
- [flutter_swiper](https://pub.dev/packages/flutter_swiper) 轮播图框架
- [flustars](https://pub.dev/packages/flustars)flustars(Flutter常用工具类库) 
- [pull_to_refresh](https://pub.dev/packages/pull_to_refresh) 上拉刷新，下拉加载框架
- [chewie](https://pub.dev/packages/chewie)Video 视频播放器框架
- [shared_preferences](https://pub.dev/packages/shared_preferences) 本地缓存框架
- [flutter_splash_screen](https://pub.dev/packages/flutter_splash_screen) 启动白屏处理框架
- [image_picker](https://pub.dev/packages/image_picker) 相册取图/拍照框架
- [multi_image_picker](https://pub.dev/packages/multi_image_picker) 多图选择
- [share](https://pub.dev/packages/share) 分享框架
- [provider](https://pub.dev/packages/provider) 状态框架
- [Get](https://pub.dev/packages/get) 路由框架
- [azlistview](https://github.com/flutterchina/azlistview)(Flutter 城市列表，联系人列表，自定义Header，索引，悬停效果)
- [dio](https://github.com/flutterchina/dio)dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时、自定义适配器等...
- [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)网络图片本地缓存
- [event_bus](https://pub.flutter-io.cn/packages/event_bus#-installing-tab-)事件总线，用户消息传递
- [Json_model](https://pub.dev/packages/json_model)根据Json文件自动生成DartModal类
- [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)丰富多样的加载指示器合集

- [Flukit](https://github.com/flutterchina/flukit)flukit （Flutter UI Kit）是一个Flutter Widget**库。

 
## 注意内容
-  新AzListView data需要a-z排过序的列表，请自行调用SuspensionUtil.sortListBySuspensionTag(list)。
 
## 关于我

我曾是一个Android开发工程师，现在主要使用ReactNative跨平台框架开发App，始终保持对新技术的学习和探索。

- WX: wayne214
- 博客：https://blog.csdn.net/wayne214
- 掘金：https://juejin.im/user/58fdbbcbda2f60005dcbe47d
- 技术网站：https://wayne214.github.io/


> 技术交流可关注微信公众号【君伟说】，加我好友(vx:wayne214)一起探讨 

> 微信交流群：加好友（备注技术交流）邀你入群，抱团学习共进步

![君伟说](https://github.com/wayne214/flutter_wtrip/blob/master/images/%E5%90%9B%E4%BC%9F%E8%AF%B4.png)