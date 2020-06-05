import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 16:52
/// progect: gwvideo

class HomeCell extends StatelessWidget {
  HomeCell({Key key, @required this.param}) : super(key: key);

  final List param;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    print(this.param);
    List<Widget> images = [];
    try {
      this.param.forEach((element) {
//        print('\n' + element);
//        print('begin \n');
//        print(element);
        images.add(
            GestureDetector(
              onTap: (){
//                print(element );
//              Nav.push(context, '${Routes.windowVideo}?index=1&id=' + swiperDataList[index]['vodid'],);
                Nav.push(context, '${Routes.tuiJianInfo}?spid=' + element['spid']);

              },
              child: Container(
                width: window.physicalSize.width / 2.0,
//          height: 100,
//        color: Colors.yellow,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
//              a,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        element['coverpic'],
                        width: window.physicalSize.width / 2 - 20,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        element['spname'],
                        style: TextStyle(
                          fontSize: 15,
//                      backgroundColor: Colors.red
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )


            ),

            );
      });
    } catch (e) {}

    return Container(
      child: Column(
        children: <Widget>[
//          Text("data"),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  width: 25.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "推荐集合",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: window.physicalSize.width,
            height: 170,
            padding: EdgeInsets.only(right: 10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //横轴三个子widget
                  childAspectRatio: 0.85 //宽高比为1时，子widget
                  ),
              scrollDirection: Axis.horizontal,
//              physics: NeverScrollableScrollPhysics(),
              children: images,
            ),
          ),
        ],
      ),
    );
  }
}
