import 'package:flutter/material.dart';
import 'package:gwvideo/pindao/ying_shi_fen_lei.dart';
import 'package:gwvideo/pindao/ying_shi_zhuan_ti.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 14:49
/// progect: gwvideo


class PinDao extends StatefulWidget{

  @override
  _PinDaoState createState() => _PinDaoState();
}

class _PinDaoState extends State<PinDao> with SingleTickerProviderStateMixin{

  TabController _tabController;
  List tabs = ['影视专题','影视分类',];
  List<Widget> _tabContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabContent = [
      YingShiZhuanTi(),
      YingShiFenLei(),
    ];

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("频道"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
            onPressed: (){
              Nav.push(context, Routes.searchPage);
            },
          )
        ],
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e,)).toList(),
          ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          YingShiZhuanTi(),
          YingShiFenLei(),
        ],
      ),
    );
  }
}