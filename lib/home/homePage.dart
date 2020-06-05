import 'package:flutter/material.dart';
import 'package:gwvideo/home/home_content_page.dart';
import 'package:gwvideo/profile/profile.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/01
/// Time: 23:20
/// progect: gwvideo


class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{


  TabController _tabController;
  List tabs = ['推荐','电影','电视剧','动漫','综艺'];
  List<Widget> _tabContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initData();
  _tabController = TabController(length: tabs.length, vsync: this);
  _tabContent = [
    HomeContent(tab:0),
    HomeContent(tab:1),
    HomeContent(tab:2),
    HomeContent(tab:3),
    HomeContent(tab:4),
  ];
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
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
          HomeContent(tab:0),
          HomeContent(tab:1),
          HomeContent(tab:2),
          HomeContent(tab:3),
          HomeContent(tab:4)
        ],
      ),
    );
  }
}