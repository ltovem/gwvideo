import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gwvideo/api/api.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:gwvideo/util/net_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 21:22
/// progect: gwvideo

class TuiJianInfo extends StatefulWidget {

  TuiJianInfo({this.spid});
  final String spid;
  @override
  _TuiJianInfoState createState() => _TuiJianInfoState();
}

class _TuiJianInfoState extends State<TuiJianInfo> {
  Map data = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    EasyLoading.showToast("sss");
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      EasyLoading.show(status:'Great Success!');
//    });
    _getTuiJianData(widget.spid);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> moveList = [];

    try {
      data['vodrows'].forEach((element) {
//        print(data['vodrows']);
        moveList.add(
          GestureDetector(
              onTap: () {
//                print('点解了' + element['title']);
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
    } catch (e) {}

    Widget gameListWidget = Container(
//      color: Colors.yellow,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => new Container(
//            color: Colors.green,
            child: Center(
                child: moveList[index],
            ),
        ),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(1,  1.6),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );

    if (data == null) {
      return Scaffold(
        appBar: AppBar(),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//
            Image.network(
              data['row']['coverpic'],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['row']['spname'],
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    data['row']['intro'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            gameListWidget,
          ],
        ),
      ),
    );
  }

  Future _getTuiJianData(String spid) async {
//    print("aaaa");
    var req = Api().getTuiJianReq(spid);

    var response;
    try {
      response = await NetUtils.get(req, {});

//      print(response['retcode']);
      setState(() {
        data = response['data'];
      });
    } catch (e) {
      print(e);
    }
    return response;
  }
}
