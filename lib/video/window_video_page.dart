import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gwvideo/api/api.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:gwvideo/util/net_utils.dart';
import 'package:gwvideo/video/util/forbidshot_util.dart';
import 'package:gwvideo/video/widget/tencent_player_bottom_widget.dart';
import 'package:gwvideo/video/widget/tencent_player_gesture_cover.dart';
import 'package:gwvideo/video/widget/tencent_player_loading.dart';

//import 'package:flutter_tencentplayer_example/full_video_page.dart';
//import 'package:flutter_tencentplayer_example/widget/tencent_player_bottom_widget.dart';
//import 'package:flutter_tencentplayer_example/widget/tencent_player_gesture_cover.dart';
//import 'package:flutter_tencentplayer_example/widget/tencent_player_loading.dart';
import 'package:screen/screen.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';

import 'full_video_page.dart';
import 'main.dart';

//import 'package:flutter_tencentplayer_example/main.dart';
//import 'package:flutter_tencentplayer_example/util/forbidshot_util.dart';

// ignore: must_be_immutable
class WindowVideoPage extends StatefulWidget {
  PlayType playType;
  String dataSource;
  String videoId;
  String Index;

  //UI
  bool showBottomWidget;
  bool showClearBtn;

  WindowVideoPage(
      {this.showBottomWidget = true,
      this.showClearBtn = true,
      this.dataSource,
      this.playType = PlayType.network,
      this.Index,
      this.videoId});

  @override
  _WindowVideoPageState createState() => _WindowVideoPageState();
}

class _WindowVideoPageState extends State<WindowVideoPage> {
  String videoId;
  String index;
  TencentPlayerController controller;
  VoidCallback listener;
  DeviceOrientation deviceOrientation;

  bool isLock = false;
  bool showCover = false;
  Timer timer;

  Map data = {};
  _WindowVideoPageState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _initController();
    controller.initialize();
    controller.addListener(listener);
    hideCover();
    ForbidShotUtil.initForbid(context);
    Screen.keepOn(true);
    videoId = widget.videoId;
    index = widget.Index;
//    _getplayData(videoId, index);
    toPlay(videoId, index);
  }

  @override
  Future dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    controller.removeListener(listener);
    controller.dispose();
    ForbidShotUtil.disposeForbid();
    Screen.keepOn(false);
  }

  _initController() {
    switch (widget.playType) {
      case PlayType.network:
        controller = TencentPlayerController.network(widget.dataSource);
        break;
      case PlayType.asset:
        controller = TencentPlayerController.asset(widget.dataSource);
        break;
      case PlayType.file:
        controller = TencentPlayerController.file(widget.dataSource);
        break;
      case PlayType.fileId:
        controller = TencentPlayerController.network(null,
            playerConfig: PlayerConfig(
                auth: {"appId": 1252463788, "fileId": widget.dataSource}));
        break;
    }
  }

  Widget _videoPlayView() {
    return (GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        hideCover();
      },
      onDoubleTap: () {
        if (!widget.showBottomWidget || isLock) return;
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          controller.play();
        }
      },
      child: Container(
        color: Colors.black,
        height: 240,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            /// 视频
            controller.value.initialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: TencentPlayer(controller),
                  )
                : Image.asset('static/place_nodata.png'),

            /// 支撑全屏
            Container(),

            /// 半透明浮层
            showCover ? Container(color: Color(0x7f000000)) : SizedBox(),

            /// 处理滑动手势
            Offstage(
              offstage: isLock,
              child: TencentPlayerGestureCover(
                controller: controller,
                showBottomWidget: widget.showBottomWidget,
                behavingCallBack: delayHideCover,
              ),
            ),

            /// 加载loading
            TencentPlayerLoading(
              controller: controller,
              iconW: 53,
            ),

            /// 头部浮层
            !isLock && showCover
                ? Positioned(
                    top: 0,
                    left: MediaQuery.of(context).padding.top,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 34, left: 10),
                        child: Image.asset(
                          'static/icon_back.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

            /// 锁
            showCover
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          isLock = !isLock;
                        });
                        delayHideCover();
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          right: 20,
                          bottom: 20,
                          left: MediaQuery.of(context).padding.top,
                        ),
                        child: Image.asset(
                          isLock
                              ? 'static/player_lock.png'
                              : 'static/player_unlock.png',
                          width: 38,
                          height: 38,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

            /// 进度、清晰度、速度
            Offstage(
              offstage: !widget.showBottomWidget,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).padding.top,
                    right: MediaQuery.of(context).padding.bottom),
                child: TencentPlayerBottomWidget(
                  isShow: !isLock && showCover,
                  controller: controller,
                  showClearBtn: widget.showClearBtn,
                  behavingCallBack: () {
                    delayHideCover();
                  },
                  changeClear: (int index) {
                    changeClear(index);
                  },
                ),
              ),
            ),

            /// 全屏按钮
            showCover
                ? Positioned(
                    right: 0,
                    bottom: 20,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => FullVideoPage(
                                controller: controller,
                                playType: PlayType.network)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset('static/full_screen_on.png',
                            width: 20, height: 20),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    ));
  }
  List<Widget>getViewItem(List param){
//    print(param);
    List<Widget> moveList = [];
//    print(param.length);
//    return moveList;


    param.forEach((element) {
//        print(data['vodrows']);
//      print(element);
      moveList.add(
        GestureDetector(
            onTap: () {
//                print('点解了' + element['title']);
//              print(element);
              Nav.push(context, '${Routes.windowVideo}?index=1&id=' + element['vodid'],);
            },
            child: Container(
//                width: window.physicalSize.width / 2.0,
//          height: 100,
//        color: Colors.purpleAccent,
//              padding: EdgeInsets.only(left: 10,right: 10),
              alignment: Alignment.centerLeft,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
//                          color: Colors.greenAccent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            element['coverpic'],
//                            'https://aaa',
                            fit: BoxFit.cover,

                          ),
                        ),
                      )
                  ),

                  Container(
//                      height: 20,
//                      color: Colors.black26,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Text(
                          element['title'],
//                          'aaa',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    });

    return moveList;
  }
  Widget getCellItem(List param,String title){
    return (
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                ),
                alignment: Alignment.centerLeft,
//            color: Colors.red,
                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  itemCount: param.length,
                  itemBuilder: (BuildContext context, int index) => new Container(
//                color: Colors.green,
                    child: Center(
                      child: (getViewItem(param))[index],
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(1,  1.6),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              )
            ],
          ),
        )
    );
  }
  //视频切换
  void changeVideo(Map param){
//    print(param);
  toPlay(videoId, param['playindex'].toString());
  }

  Widget getBtnView(Map Param){
    return (
    Container(
//      color: Colors.blue,


      padding: EdgeInsets.only(left: 2.5,right: 2.5),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: (){
          changeVideo(Param);
        },
        child: ClipRRect(

          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            color: Colors.blue,
            width: 80,
            height: 34,
            child: Center(
              child: Text(
                Param['play_name'],
                style: TextStyle(
                  fontSize: 18,
                ),
            ),
            ),
          ),
        ),
      ),
    )
    );
  }
  List<Widget> getCell(){
    List<Widget> widgets = [];
    if (data['vodrow'] == null){
      widgets.add(Center());
      return widgets;
    }
    widgets.add(Container(
      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              data['vodrow']['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            data['vodrow']['yearname'] + '年 | ' + data['vodrow']['scorenum'] + '分 | ' +
                data['vodrow']['catename'] + ' | ' + data['vodrow']['areaname'] + '/' +
                data['vodrow']['areaname'],
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(height: 5,),
          Text(
              data['vodrow']['intro'],
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    ));

    List<Widget> btnV = [];
    data['vodrow']['playlist'].forEach((element) {
      btnV.add(SizedBox(width: 2.5,));
      btnV.add(getBtnView(element));
//      btnV.add(SizedBox(width: 2.5,));
    });
    widgets.add(Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '选集',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 44,
//            color: Colors.purple,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: ListView(
              children: btnV.length < 1 ? [Center()] : btnV,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    ));
    widgets.add(getCellItem(data['similarrows'], '相似推荐'));
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 240,
            child: _videoPlayView(),
            color: Colors.purpleAccent,
          ),
          Expanded(
//            flex: 3,
            child: Container(

              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 0),
//              margin: EdgeInsets.only(top: -10),
              child: ListView(

                children: getCell().length < 1 ? [Center()] : getCell(),

              ),
//              color: Colors.yellow,

            ),
          )
        ],
      ),
    );
  }

  List<String> clearUrlList = [
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4',
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f20.mp4',
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f30.mp4',
  ];

  changeClear(int urlIndex, {int startTime}) {
    print(urlIndex);
    controller?.removeListener(listener);
    controller?.pause();
    controller = TencentPlayerController.network(clearUrlList[urlIndex],
        playerConfig: PlayerConfig(
            startTime: startTime ?? controller.value.position.inSeconds));
    controller?.initialize()?.then((_) {
      if (mounted) setState(() {});
    });
    controller?.addListener(listener);
  }

  play(String urlIndex, {int startTime}) {
    print(urlIndex);
    controller?.removeListener(listener);
    controller?.pause();
    controller = TencentPlayerController.network(urlIndex,
        playerConfig: PlayerConfig(
            startTime: startTime ?? controller.value.position.inSeconds));
    controller?.initialize()?.then((_) {
      if (mounted) setState(() {});
    });
    controller?.addListener(listener);
  }

  hideCover() {
    if (!mounted) return;
    setState(() {
      showCover = !showCover;
    });
    delayHideCover();
  }

  delayHideCover() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    if (showCover) {
      timer = new Timer(Duration(seconds: 6), () {
        if (!mounted) return;
        setState(() {
          showCover = false;
        });
      });
    }
  }

  void toPlay(String videoid, String index) {
    _getplayData(videoid, index);
    _getplayContentData(videoid, index);
  }

  Future _getplayContentData(String vodeoId, String index) async {
    print("aaaa");
    var req = Api().getReqPlayContent(vodeoId, index);

    var response;
    try {
      response = await NetUtils.get(req, {});

      print(response['data']['httpurl']);

//      changeClear( url:response['data']['httpurl'],startTime: 0);
      play(response['data']['httpurl'], startTime: 14);
      setState(() {
        data = response['data'];
      });
    } catch (e) {
//      print(e);
    }
    return response;
  }

  Future _getplayData(String vodeoId, String index) async {
    print("aaaa");
    var req = Api().getReqPlay(vodeoId, index);

    var response;
    try {
      response = await NetUtils.get(req, {});

      print(response['data']['httpurl']);

//      changeClear( url:response['data']['httpurl'],startTime: 0);
      play(response['data']['httpurl'], startTime: 14);
      setState(() {
//        data = response['data'];
      });
    } catch (e) {
//      print(e);
    }
    return response;
  }
}
