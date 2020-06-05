/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/03
/// Time: 14:27
/// progect: gwvideo


//import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tencentplayer/controller/tencent_player_controller.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({@required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
//  final FijkPlayer player = FijkPlayer();

  TencentPlayerController _controller;
//  initState() {
//    _controller = TencentPlayerController.network('http://file.jinxianyun.com/testhaha.mp4', playerConfig: PlayerConfig())
//    //_controller = TencentPlayerController.asset('static/tencent1.mp4')
//    //_controller = TencentPlayerController.file('/storage/emulated/0/test.mp4')
//    //_controller = TencentPlayerController.network(null, playerConfig: {auth: {"appId": 1252463788, "fileId": '4564972819220421305'}})
//      ..initialize().then((_) {
//        setState(() {});
//      });
////    _controller.addListener(listener);
//  }

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    _controller = TencentPlayerController.network('https://mu.qqxy100.com/ts/2/101581339291025408/index.m3u8?wssecret=259aa493f7ad54c2b5e3f41b0ba8405e&wstime=1591166000', playerConfig: PlayerConfig());
//    player.setDataSource('https://mu.qqxy100.com/ts/2/101581339291025408/index.m3u8?wssecret=259aa493f7ad54c2b5e3f41b0ba8405e&wstime=1591166000', autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: TencentPlayer(
            _controller
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
//    player.release();
  }
}