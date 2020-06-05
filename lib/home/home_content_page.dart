import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gwvideo/api/api.dart';
import 'package:gwvideo/home/view/cell_Item.dart';
import 'package:gwvideo/routers/nav.dart';
import 'package:gwvideo/routers/routers.dart';
import 'package:gwvideo/util/net_utils.dart';

/// Created with Android Studio.
/// User: 田高伟
/// email: t@ltove.com
/// https://blog.ltove.com
/// Date: 2020/06/02
/// Time: 15:18
/// progect: gwvideo

class HomeContent extends StatefulWidget {
  HomeContent({Key key, this.tab}) : super(key: key);

  final int tab;

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List _bannerList = [];
  Map _data = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHomeData(widget.tab);
  }
  List<Widget> getListViews(){
    List<Widget> widges = [];

    if (_data == null){
      widges.add(Center());
      return widges;
    }
    widges.add(
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: SwiperDiy(
          swiperDataList: _bannerList,
        ),
      ),
    );
    widges.add(HomeCell(param: _data['sprows']));
    widges.add(getCellItem(_data['dayrows'],'今日推荐'));
    widges.add(getCellItem(_data['hotrows'], '热门推荐'));

    //其他推荐
    _data['nestedrows'].forEach((element) {
      widges.add(getCellItem(element['vodrows'], element['caption']));
    });

    return widges;
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      body: SwiperDiy(swiperDataList: _bannerList),
      body: Padding(
        padding: EdgeInsets.only(top: 0),
        child: ListView(
          children: getListViews(),
        ),
      ),
    );


  }

  Future _getHomeData(int tab) async {
    var req = Api().getHomeReq(tab);

    var response;

    try {
      response = await NetUtils.get(req, {});
      print("object");
//      print(response['data']);
      setState(() {
        _bannerList = response['data']['sliderows'];
        _data = response['data'];
      });
    } catch (e) {
//      print("object");
      print(e);
    }
    return response;
  }
}

/// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (swiperDataList.length < 1) {
      return Container(
        width: 750,
        height: 20,
      );
    }
    return Container(
//      width: ScreenUtil().setWidth(375),
//      height: ScreenUtil().setHeight(200),
      width: 750,
      height: 160,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        // 横向
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                //轮播图点击跳转详情页
//                Toast.show('您点击了${swiperDataList[index]}');
//              print(ScreenUtil().setWidth(540));
                Nav.push(context, '${Routes.windowVideo}?index=1&id=' + swiperDataList[index]['vodid'],);
              print('sss');
//              print(swiperDataList);
              },
              child: Container(
                decoration: BoxDecoration(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("${swiperDataList[index]["pic"]}"),
                      fit: BoxFit.fill,
                    )),
              ));
        },
        itemCount: swiperDataList.length,
        //pagination: new SwiperPagination(),
        autoplay: true,
        viewportFraction: 0.8,
        // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 0.8,
        // 两张图片之间的间隔
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.white.withOpacity(0.5),
            activeColor: Colors.white,
          ),

//            margin: EdgeInsets.all(ScreenUtil().setWidth(10))
        ),
      ),
    );
  }
}
