import 'package:flutter/material.dart';
import 'package:gwvideo/discover/discover_content.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 14:47
/// progect: gwvideo

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = [
    '电影',
    '电视剧',
    '动漫',
    '综艺'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("观影排行"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),
              onPressed: (){
                Nav.push(context, Routes.searchPage);
              },
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          )),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DiscoverConteng(tab:2),
          DiscoverConteng(tab: 3),
          DiscoverConteng(tab: 5,),
          DiscoverConteng(tab: 4,),
        ],
      ),
    );
  }
}
