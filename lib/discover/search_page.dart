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
/// Time: 15:38
/// progect: gwvideo


class SearchPage extends StatefulWidget{

  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage>{

  Map data;
  @override
  Widget build(BuildContext context) {


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
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Container(
          height: 44,
          child: TextField(

            decoration: InputDecoration(
              hintText: '搜索',
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 15),
              fillColor: Color(0XFFFFF8F4),
              filled: true,
              enabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.all(
                  Radius.circular(5), //边角为5
                ),
                borderSide: BorderSide(
                  color: Colors.white, //边线颜色为白色
                  width: 1, //边线宽度为2
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, //边框颜色为白色
                  width: 1, //宽度为5
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5), //边角为30
                ),
              ),

            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (v){
//              print('sss' + v);
              _getSearchData(v);
            },
          ),
        ),
      ),
      body: ListView(
        children: viewList,
      ),
    );
  }



  Future _getSearchData(String keywords) async {
//    print("aaaa");
    var req = Api().getSearchReq(keywords);

    print(req);
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