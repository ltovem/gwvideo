/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/01
/// Time: 20:15
/// progect: gwvideo

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

enum ENV {
  PRODUCTION,
  DEV,
}

class Application {
  /// 通过application设置环境变量
  static ENV env = ENV.DEV;
  static Router router;
  static TabController controller;


  Map<String,String> get config{
    if(Application.env == ENV.PRODUCTION){
      return {};
    }
    if(Application.env == ENV.DEV){
      return {};
    }
    return {};
  }
}
