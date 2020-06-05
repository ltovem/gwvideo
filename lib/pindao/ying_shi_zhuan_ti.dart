import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gwvideo/api/api.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:gwvideo/util/net_utils.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/03
/// Time: 23:47
/// progect: gwvideo

class YingShiZhuanTi extends StatefulWidget {
  @override
  _YingShiZhuanTiState createState() => _YingShiZhuanTiState();
}

class _YingShiZhuanTiState extends State<YingShiZhuanTi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _geiZhuanTi();
  }

  Map data;

  @override
  Widget build(BuildContext context) {
    List<Widget> viewList = [];

    try {

//      print(data['rows']);
      data['rows'].forEach((element) {
        print(element);
        viewList.add(GestureDetector(
          onTap: (){
            Nav.push(context, '${Routes.tuiJianInfo}?spid=' + element['spid']);
          },
          child: Column(
            children: <Widget>[
              Container(
//                flex: 1,
                child: Image.network(
                  element['coverpic'],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  element['spname'],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ));
      });
    } catch (e) {}
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: viewList,
      ),
    );
  }

  Future _geiZhuanTi() async {
    var req = Api().getYingShiZhuanTiReq();

    var response;

    try {
      response = await NetUtils.get(req, {});
//      print("object");
//      print(response['data']);
      setState(() {
        data = response['data'];
      });
    } catch (e) {
      print("object");
      print(e);
    }
    return response;
  }
}
