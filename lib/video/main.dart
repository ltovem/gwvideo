import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwvideo/video/window_video_page.dart';

import 'download_page.dart';
import 'full_video_page.dart';
//import 'package:flutter_tencentplayer_example/download_page.dart';
//import 'package:flutter_tencentplayer_example/full_video_page.dart';
//import 'package:flutter_tencentplayer_example/window_video_page.dart';

//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//  ]);
//  runApp(MyApp());
//}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.pink),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => ListPage(),
          'window': (_) => WindowVideoPage(),
          'full': (_) => FullVideoPage(),
          'download': (_) => DownloadPage(),
        }
    );
  }
}

enum PlayType {
  network,
  asset,
  file,
  fileId,
}

String networkMp4 = 'https://mu.qqxy100.com/ts/2/101581339291025408/index.m3u8?wssecret=259aa493f7ad54c2b5e3f41b0ba8405e&wstime=1591166000';
String liveUrl1 = 'http://5815.liveplay.myqcloud.com/live/5815_89aad37e06ff11e892905cb9018cf0d4.flv';
String liveUrl2 = 'rtmp://58.200.131.2:1935/livetv/hunantv';
String assetPath = 'static/tencent1.mp4';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('腾讯播放器Demo'),),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('小窗视频'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => WindowVideoPage(playType: PlayType.network, dataSource: networkMp4,)));
            },
          ),
          ListTile(
            title: Text('网络视频'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => FullVideoPage(playType: PlayType.network, dataSource: networkMp4,)));
            },
          ),
          ListTile(
            title: Text('直播1'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => FullVideoPage(playType: PlayType.network, dataSource: liveUrl1, showBottomWidget: false, showClearBtn: false,)));
            },
          ),
          ListTile(
            title: Text('直播2'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => FullVideoPage(playType: PlayType.network, dataSource: liveUrl2, showBottomWidget: false, showClearBtn: false,)));
            },
          ),
          ListTile(
            title: Text('file视频'),
            subtitle: Text('（在/storage/emulated/0/test.mp4放对应视频，并打开文件读写权限）', style: TextStyle(fontSize: 10, color: Color(0xff999999)),),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => FullVideoPage(playType: PlayType.file, dataSource: '/storage/emulated/0/test.mp4',)));
            },
          ),
          ListTile(
            title: Text('asset视频'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => FullVideoPage(playType: PlayType.asset, dataSource: assetPath,)));
            },
          ),
          ListTile(
            title: Text('下载播放视频'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => DownloadPage()));
            },
          ),
        ],
      ),
    );
  }
}

