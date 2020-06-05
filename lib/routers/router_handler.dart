/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/01
/// Time: 20:42
/// progect: gwvideo

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gwvideo/discover/search_page.dart';
import 'package:gwvideo/home/tui_jian_info_page.dart';
import 'package:gwvideo/video/full_video_page.dart';
import 'package:gwvideo/video/video_play_page.dart';
import 'package:gwvideo/video/window_video_page.dart';
import 'package:gwvideo/views/404.dart';

var widgeSearchhandler =new Handler(
  handlerFunc: (context, parameters) {
    return SearchPage();
  },
);
var widgeNotFounfhandler =new Handler(
  handlerFunc: (context, parameters) {
    return WidgetNotFound();
  },
);

var widgetTuiJianInfoHandler = new Handler(
  handlerFunc: (context,Map<String, List<String>>parameters){
    String spid = parameters['spid'].first;
    return TuiJianInfo(spid: spid,);
  },
);
var widgetVideoPlayHandler = new Handler(
  handlerFunc: (context,parameters){
    return VideoScreen();
  },
);
var widgetFullVideoHandler = new Handler(
  handlerFunc: (context,parameters){
    return FullVideoPage(dataSource: 'https://mu.qqxy100.com/ts/2/101581339291025408/index.m3u8?wssecret=259aa493f7ad54c2b5e3f41b0ba8405e&wstime=1591166000',);
  },
);

var widgetWindowVideoHandler = new Handler(
  handlerFunc: (context,Map<String, List<String>> parameters){
    print('---------------------------');
    print(parameters);
    String videoId = parameters['id'].first;
    String index = parameters['index'].first;
    return WindowVideoPage(Index :index,videoId: videoId,);
  },
);
