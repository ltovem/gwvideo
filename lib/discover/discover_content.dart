

import 'package:flutter/material.dart';
import 'package:gwvideo/api/api.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:gwvideo/util/net_utils.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/04
/// Time: 11:46
/// progect: gwvideo


class DiscoverConteng extends StatefulWidget{
  DiscoverConteng({this.tab});
  final int tab;
  
  @override
  _DiscoverContengState createState() => _DiscoverContengState();
}

class _DiscoverContengState extends State<DiscoverConteng> with AutomaticKeepAliveClientMixin{

  int pageIndex = 0;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Map data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTuiJianData(widget.tab, pageIndex);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> viewList = [];

    try{
      data['vodrows'].forEach((element) {
        viewList.add(
          GestureDetector(
            onTap: (){
              Nav.push(context, '${Routes.windowVideo}?index=1&id=' + element['vodid'],);
            },
            child: Container(
              margin: EdgeInsets.only(top: 5),
//            color: Colors.red,

              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              height: 200,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      child: Image.network(
                        element['coverpic'],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            element['title'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            element['intro'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          )

        );
      });
    }catch (e){

    }
    return Scaffold(
      body: ListView(
        children: viewList,
      ),
    );
  }

  Future _getTuiJianData(int tab,int index) async {
//    print("aaaa");
    var req = Api().getPaiHangReq(tab, index);

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