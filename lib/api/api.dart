import 'package:gwvideo/video/util/util.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/03
/// Time: 17:31
/// progect: gwvideo


class Api {
  // 工厂模式
  factory Api() =>_getInstance();
  static Api get instance => _getInstance();
  static Api _instance;
  Api._internal() {
    // 初始化
  }
  static Api _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }


  static  String domain = 'https://' +Util().getRundomStr(20) + '.xiaoxiaoimg.com';
  static String s_device_id = Util().getRundomStr(25);
  static String s_platform = 'android';
  static String s_os_version = '12.0';

  static String REQ_PLAY = domain + '/vod/reqplay/';
  static String REQ_PLAY_SHOW = domain + '/vod/show/';
  static String Home_REQ = domain + '/index?';
  static String TUI_JIAN_REQ = domain + '/special/detail/';

  static String PAI_HANG = domain + '/vod/day-';



  String getReqPlay(String vodioId,String index){
    return REQ_PLAY + vodioId + '?playindex=' + index;
  }
  String getReqPlayContent(String vodioId,String index){
    return REQ_PLAY_SHOW + vodioId + '?playindex=' + index;
  }

  String getHomeReq(int tab){
    return Home_REQ + 'tab=' + tab.toString();
  }

  String getTuiJianReq(String req){
    return TUI_JIAN_REQ + req +'?';
  }

  String getYingShiZhuanTiReq(){
    return domain + '/special/listing-0-0-1?';
  }
  String getPaiHangReq(int tab,int index){
    return PAI_HANG + tab.toString() + '-0-0-0-0-0-' + index.toString() + '?';
  }

  String getSearchReq(String keywords){
    return domain + '/search?wd=' + Uri.encodeComponent(keywords);
  }
}