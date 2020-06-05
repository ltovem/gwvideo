/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/01
/// Time: 21:03
/// progect: gwvideo

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handler.dart';

class Routes {
  static String root = "/";
  static String widgetNotFound = "/views/404";
  static String tuiJianInfo = "../home/tui_jian_info_page";
  static String videoPlay = "../video/video_play_page";
  static String fullVideo = "../video/full_video_page";
  static String windowVideo = "../video/window_video_page";
  static String searchPage = '../discover/search_page';

  static void configureRoutes(Router router){
    // List widgetDemosList = new Wi

    router.define('/views/404', handler: widgeNotFounfhandler);
    router.define(tuiJianInfo, handler: widgetTuiJianInfoHandler);
    router.define(videoPlay, handler: widgetVideoPlayHandler);
    router.define(fullVideo, handler: widgetFullVideoHandler);
    router.define(windowVideo, handler: widgetWindowVideoHandler);
    router.define(searchPage, handler: widgeSearchhandler);
  }
}
