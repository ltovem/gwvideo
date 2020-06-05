/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 14:41
/// progect: gwvideo
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gwvideo/discover/discover.dart';
import 'package:gwvideo/home/homePage.dart';
import 'package:gwvideo/pindao/pin_dao_page.dart';
import 'package:gwvideo/profile/profile.dart';

class BottomBar extends StatefulWidget{

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>{

  int _selectedIndex = 0;
  List<Widget> _pageList;
  final _appBarTitles = ['首页'];
  final _pageController = PageController();


  void initData(){
    _pageList = [
//      Home(),
      Profile(),
      Profile(),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
//      appBar: AppBar(
//        title: Text("首页"),
//      ),
        body: PageView(

          children: <Widget>[
            Home(),
            PinDao(),
            Discover(),
            Profile()
          ],
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar( // 底部导航
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('频道')),
            BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('发现')),
            BottomNavigationBarItem(icon: Icon(Icons.sd_card), title: Text('我的')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.blue,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,

        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;

    });
  }
}