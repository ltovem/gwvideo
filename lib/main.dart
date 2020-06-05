import 'package:fluro/fluro.dart';
import 'package:gwvideo/home/bottom_bar.dart';
import 'package:gwvideo/home/homePage.dart';
import 'package:gwvideo/profile/profile.dart';
import 'package:gwvideo/routers/application.dart';
import 'package:gwvideo/routers/router_handler.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:oktoast/oktoast.dart';
//import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:gwvideo/routers/nav.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {

  VideoApp(){
//    创建一个router对象
    final router = Router();
    //配置Routes注册管理
    Routes.configureRoutes(router);
    //将生成的router给全局化
    Application.router = router;
  }

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
//  VideoPlayerController _controller;

  

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child:MaterialApp(
          title: 'Video Demo',
          home: BottomBar(),
          onGenerateRoute: Application.router.generator,
        )
    );
//    return MaterialApp(
//      title: 'Video Demo',
//      home: BottomBar(),
//      onGenerateRoute: Application.router.generator,
//    );
  }


}