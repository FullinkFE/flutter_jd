import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jd/util/constants.dart';
import 'package:flutter_jd/widget/after_layout.dart';
import 'package:flutter_jd/widget/arc_transition.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiver/iterables.dart';

///分类item
class _CategoryItem {
  final Icon _icon;
  final String _text;

  _CategoryItem(this._icon, this._text);
}

///中间tab项数据
class _MidTabItem {
  final String _title;
  final String _subTitle;
  final AnimationController _animationController;

  _MidTabItem(this._title, this._subTitle, this._animationController);
}

///首页
class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ScrollController _scrollController;
  double _opacity = 1.0;
  List<_MidTabItem> _midTabs;
  int _initialAnim = 0;

  //将要消失的动画控制器
  AnimationController _currentAniController;

  //将要显示的动画控制器
  AnimationController _nextAniController;

  PageController _mPageController = PageController(initialPage: 0);

  ///首页-可左右滚动数据源
  List<_CategoryItem> categories = [
    _CategoryItem(Icon(Icons.camera), "京东超市"),
    _CategoryItem(Icon(Icons.camera), "数码电器"),
    _CategoryItem(Icon(Icons.camera), "京东服务"),
    _CategoryItem(Icon(Icons.camera), "京东生鲜"),
    _CategoryItem(Icon(Icons.camera), "京东到家"),
    _CategoryItem(Icon(Icons.camera), "充值缴费"),
    _CategoryItem(Icon(Icons.camera), "领京豆"),
    _CategoryItem(Icon(Icons.camera), "领券"),
    _CategoryItem(Icon(Icons.camera), "领券赚钱"),
    _CategoryItem(Icon(Icons.camera), "PLUS会员"),
    _CategoryItem(Icon(Icons.camera), "海屯全球"),
    _CategoryItem(Icon(Icons.camera), "京东拍卖"),
    _CategoryItem(Icon(Icons.camera), "唯品会"),
    _CategoryItem(Icon(Icons.camera), "沃尔玛"),
    _CategoryItem(Icon(Icons.camera), "京东旅行"),
    _CategoryItem(Icon(Icons.camera), "看病购药"),
    _CategoryItem(Icon(Icons.camera), "拍拍二手"),
  ];

  //触发向上滚动的临界点
  int _scrollDistance;

  //search的宽度，不变化（重新初始化赋值用）
  double _searchWidth;

  //实际变化的搜索框宽度
  double _searchTraverWidth;

  //搜索栏的高度
  double _searchHeight = 36;

  //搜索框上边距离状态栏的高度
  double _searchTravelTop;

  //搜索栏的一层父容器高度
  double _searchContainerHeight = 58;

  //需要向上/向下移动的距离，不会动态改变
  double _travelTop;

  //需要向上/向下移动的距离，会动态改变
  double _travelTopDistance;

  TabController _mTabController;

  bool isPageCanChanged = true;

  AnimationController _animationController;

  bool fling = false;
  ScrollPositionWithSingleContext _context;

  @override
  void initState() {
    super.initState();
    _initMidTab();
    _scrollController = ScrollController()
      ..addListener(() {
        ScrollPositionWithSingleContext _context =
            _scrollController.position as ScrollPositionWithSingleContext;
        this._context = _context;
//        print(
//            '_HomeState.initState pixels:${_scrollController.offset.toInt()}, _travelTopDistance:$_travelTopDistance,_travelTop:$_travelTop'
//            '_direction:${_context.userScrollDirection}');

        if ((_travelTopDistance == 0 &&
                ScrollDirection.reverse == _context.userScrollDirection) ||
            (_travelTopDistance >= _travelTop &&
                ScrollDirection.forward == _context.userScrollDirection)) {
          _scrollDistance ??= _scrollController.offset.toInt();
          return;
        }
        updateState(_context);
      });
  }

  ///更新头部动画属性
  void updateState(ScrollPositionWithSingleContext _context, {double value}) {
    if (_context == null) {
      return;
    }
    //向下滑动，屏幕下滚
    if (ScrollDirection.forward == _context.userScrollDirection) {
      _searchTraverWidth += 1.6;
      _searchContainerHeight += 1;
      _searchTravelTop += 1;
      _travelTopDistance += 1;
    } else if (ScrollDirection.reverse == _context.userScrollDirection) {
      _searchTraverWidth -= 1.6;
      _searchContainerHeight -= 1;
      _searchTravelTop -= 1;
      _travelTopDistance -= 1;
    }
    _opacity = (_travelTopDistance / _travelTop).clamp(0, 1).toDouble();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          height: MediaQuery.of(context).size.height,
          top: 81,
          width: MediaQuery.of(context).size.width,
          child: Listener(
            onPointerUp: _onPointerUp,
            onPointerDown: _onPointerDown,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: kToolbarHeight,
                          margin: EdgeInsets.only(top: 6),
                          width: MediaQuery.of(context).size.width,
//                padding:
//                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                          child: Text(""),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "resource/image/over_pure_bg.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                            height: 120,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
//            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  imgs.elementAt(index),
                                  fit: BoxFit.cover,
                                );
                              },
//                  curve: ElasticInCurve(),
                              autoplay: true,
                              onIndexChanged: (_) {
//                            var aa = [1,2,3,4,5];
//                            print("aa sublist : ${aa.sublist(3).length}");
                              },
                              itemCount: imgs.length,
//                          itemWidth: 200,
//                          itemHeight: 100,
//                          layout: SwiperLayout.CUSTOM,
//                          customLayoutOption: new CustomLayoutOption(
//                                  startIndex: -1, stateCount: imgs.length)
//                              .addRotate(
//                                  [-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
//                            new Offset(-370.0, -40.0),
//                            new Offset(0.0, 0.0),
//                            new Offset(370.0, -40.0)
//                          ]),
                              pagination: SwiperPagination(),
//                  control: SwiperControl(),
//                  viewportFraction: 0.8,
                              scale: 0.9,
                            ))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  margin: EdgeInsets.only(top: 6),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
//              color: Colors.lightBlueAccent,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCategory(index);
                    },
                    autoplay: false,
                    outer: false,
                    loop: false,
                    itemCount: (categories.length / 10).ceil(),
                    pagination: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return Align(
                        child: Wrap(
                          children: range(config.itemCount).map((index) {
                            return Container(
                              margin: EdgeInsets.only(right: 6),
                              width: config.activeIndex == index ? 10 : 6,
                              height: 2,
                              decoration: ShapeDecoration(
                                  color: config.activeIndex == index
                                      ? Colors.black
                                      : colorGreyFF939BAC,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                            );
                          }).toList(),
                        ),
                        alignment: Alignment.bottomCenter,
                      );
                    }),
                  ),
                )),
                SliverToBoxAdapter(
                  child: Container(
//                height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //京东秒杀
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text("京东秒杀"),
                                        Container(
                                          height: 20,
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 20,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: Text(
                                                  "14点场",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.redAccent),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6),
                                                child: Text(
                                                  "00.00.23",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                          decoration: ShapeDecoration(
//                                          color: Colors.yellowAccent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Colors.redAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
//
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Image.asset(
                                              "resource/image/icon_bill.png",
                                              height: 30,
                                              alignment: Alignment.center,
                                            ),
                                            Text("￥479"),
                                            Text("￥600",
                                                style: TextStyle(
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ],
                                        ),
                                        Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Image.asset(
                                              "resource/image/icon_bill.png",
                                              height: 30,
                                              alignment: Alignment.center,
                                            ),
                                            Text("￥479"),
                                            Text("￥600",
                                                style: TextStyle(
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ],
                                        ),
                                        Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Image.asset(
                                              "resource/image/icon_bill.png",
                                              height: 30,
                                              alignment: Alignment.center,
                                            ),
                                            Text("￥479"),
                                            Text("￥600",
                                                style: TextStyle(
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            //发现好货
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Text("发现好货"),
                                        Text("品质新生活"),
                                        Image.asset(
                                          "resource/image/icon_bill.png",
                                          height: 60,
                                          width: 50,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text(""),
                                      Text(""),
                                      Image.asset(
                                        "resource/image/icon_bill.png",
                                        height: 60,
                                        width: 50,
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                        //品牌秒杀
                        Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      children: <Widget>[
                                        Text("品牌秒杀"),
                                        Text("低至9.9"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      children: <Widget>[
                                        Text("品类秒杀"),
                                        Text("低至9.9"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ))
                                  ],
                                )),
                            //闪购
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Text("闪购"),
                                        Text("品牌特卖"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text(""),
                                      Text(""),
                                      Image.asset(
                                        "resource/image/icon_qq.png",
                                        height: 60,
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                        //逛好店
                        Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      children: <Widget>[
                                        Text("逛好店"),
                                        Text("懂你想要的"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      children: <Widget>[
                                        Text("新品首发"),
                                        Text("玩转小魔方"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ))
                                  ],
                                )),
                            //排行榜
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Text("排行榜"),
                                        Text("跟榜购好物"),
                                        Image.asset(
                                          "resource/image/icon_qq.png",
                                          height: 60,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text(""),
                                      Text(""),
                                      Image.asset(
                                        "resource/image/icon_qq.png",
                                        height: 60,
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.redAccent,
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: 0),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6))),
                          margin: EdgeInsets.only(top: 1),
                          child: Row(
                            children: <Widget>[
                              Text("快报"),
                              Expanded(
                                  child: Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.network(
                                        imgs.elementAt(index),
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    autoplay: true,
//                              duration: 5,
                                    scrollDirection: Axis.vertical,
                                    onIndexChanged: (_) {},
                                    itemCount: imgs.length,
                                    scale: 1,
                                  ),
                                ),
                              )),
                              Text("更多"),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: ShapeDecoration(
//                      color: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: ShapeDecoration(
//                      color: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: <Widget>[
                            Text("我的频道"),
                            Wrap(
                              children: <Widget>[
                                Text("发现更多频道"),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                            Container(
//                          margin: EdgeInsets.symmetric(horizontal: 15),
                              width: MediaQuery.of(context).size.width - 30,
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 8) {
                                    return Wrap(
                                      runAlignment: WrapAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.arrow_back),
                                        Text("查看更多")
                                      ],
                                    );
                                  }
                                  return Container(
                                    width: 80,
//                                  color: Colors.redAccent,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          height: 60,
                                          alignment: Alignment.bottomCenter,
                                          child: Text("推荐-$index"),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "resource/image/icon_my_card.png"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.opacity),
                                            Text("京东会员")
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 9,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomSliverPersistentHeaderDelegate(
                      minHeight: 60,
                      maxHeight: 60,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                          onTap: (_index) {
                            onPageChange(_index, p: _mPageController);
                          },
                          isScrollable: true,
                          //是否可以滚动
                          controller: _mTabController,
                          labelColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Color(0xff666666),
                          labelStyle: TextStyle(fontSize: 16.0),
                          tabs: _buildTabs(),
                        ),
                      ),
                    )),
//              SliverList(
//                  delegate: SliverChildListDelegate.fixed(range(40).map((_num) {
//                return GestureDetector(
//                  child: Card(
//                    child: Text("商品-$_num"),
//                  ),
//                  onTap: () {
//                    print("商品-$_num");
//                  },
//                );
//              }).toList())),
                SliverFillRemaining(
                  child: PageView.builder(
                    physics: PageScrollPhysics(),
                    itemCount: _midTabs.length,
                    onPageChanged: (index) {
//                    print("onPageChanged in $index $isPageCanChanged");
                      //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                      if (isPageCanChanged) {
                        onPageChange(index);
                      }
                    },
                    controller: _mPageController,
                    itemBuilder: (BuildContext context, int index) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Text("$index");
                        },
                        itemCount: 60,
                      );
                    },
                  ),
                )
//              SliverList(
//                  delegate: SliverChildBuilderDelegate(
//                      (BuildContext context, int index) {
//                return Container(
//                  child: PageView.builder(
//                    itemCount: _midTabs.length,
//                    onPageChanged: (index) {
//                      print("onPageChanged in $index");
//                      //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
//                      if (isPageCanChanged) {
//                        onPageChange(index);
//                      }
//                    },
//                    controller: mPageController,
//                    itemBuilder: (BuildContext context, int index) {
//                      return ListView.builder(
//                        shrinkWrap: true,
//                        itemBuilder: (BuildContext context, int index) {
//                          return Text("$index");
//                        },
//                        itemCount: 50,
//                      );
//                    },
//                  ),
//                );
//              }, childCount: 40)),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            height: MediaQuery.of(context).padding.top +
                kToolbarHeight +
                _searchContainerHeight,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
//              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Opacity(
                        opacity: _opacity,
                        child: AfterLayout(
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.wb_incandescent,
                                color: Colors.white,
                              ),
                              Text("京东", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          onAfter: (context) {
                            _travelTop ??= _travelTopDistance ??=
                                (kToolbarHeight + _searchContainerHeight) / 2;
//                            print("京东 contribute is : $_travelTop");
                          },
                        ),
                      ),
                      Wrap(
                        spacing: 6,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.grade,
                            color: Colors.white,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Icon(
                                Icons.scanner,
                                color: Colors.white,
                              ),
                              Text(
                                "扫一扫",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          GestureDetector(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: <Widget>[
                                Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                ),
                                Text("消息",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            onTap: () {
//                              Navigator.pushNamed(context, "/testpt");
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: _searchTravelTop ??= kToolbarHeight +
                        (_searchContainerHeight - _searchHeight) / 2,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        height: _searchHeight,
                        width: _searchTraverWidth ??= _searchWidth ??=
                            (MediaQuery.of(context).size.width - 30),
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.search),
                            Icon(Icons.camera)
                          ],
                        ),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            color: Colors.white),
                      );
                    }))
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("resource/image/rect_bg.png"),
                    fit: BoxFit.cover)),
          ),
        )
      ],
    );
  }

  var imgs = [
    "https://img4.mukewang.com/szimg/59b8a486000107fb05400300.jpg",
    "https://img3.mukewang.com/szimg/5a7127370001a8fa05400300.jpg",
    "https://img4.mukewang.com/szimg/5c18d2d8000141c506000338.jpg"
  ];

  //每页数据是10条
  int _categoryCount = 10;

  ///构造当前显示的分类数据源，滚动后会重新计算当前显示的数据
  Widget _buildCategory(int index) {
    range(3);
    List tempLists = [];

    tempLists = categories
        .getRange(
            index * _categoryCount,
            categories.length >= (index + 1) * _categoryCount
                ? _categoryCount
                : index * _categoryCount +
                    categories.sublist(index * _categoryCount).length)
        .toList();
//    print("get out $index,tempLists is ${tempLists.length}");
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        runSpacing: 10,
        runAlignment: WrapAlignment.center,
        children: tempLists.map((item) {
          return GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width - 30) / 5,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: <Widget>[
                  item._icon,
                  Text(
                    item._text,
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
            onTap: () {
              print("category item click in ${item._text}");
            },
          );
        }).toList(),
      ),
    );
  }

  void _initMidTab() {
    _midTabs = <_MidTabItem>[
      _MidTabItem(
          "精选",
          "为你推荐",
          AnimationController(
              vsync: this, duration: Duration(milliseconds: 200))),
      _MidTabItem(
          "超市",
          "百货生鲜",
          AnimationController(
              vsync: this, duration: Duration(milliseconds: 200))),
      _MidTabItem(
          "电器",
          "3C家电",
          AnimationController(
              vsync: this, duration: Duration(milliseconds: 200))),
      _MidTabItem(
          "时尚",
          "美妆穿搭",
          AnimationController(
              vsync: this, duration: Duration(milliseconds: 200))),
      _MidTabItem(
          "生活",
          "居家日用",
          AnimationController(
              vsync: this, duration: Duration(milliseconds: 200))),
    ];

    _mTabController = TabController(
      length: _midTabs.length,
      vsync: this,
    );
  }

  ///page+tab监听
  onPageChange(int index, {PageController p, TabController t}) async {
    print(
        '_HomeState.onPageChange _mPageController,$index, ${_mPageController.page.toInt()},p:$p');

    //点击Tab选项卡
    if (p != null) {
      print('~~~~~~~~~~~~ ppp ${_mPageController.page.toInt()}');
      _currentAniController =
          _midTabs[_mPageController.page.toInt()]._animationController;
      isPageCanChanged = false;
      await _mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      isPageCanChanged = true;
      _nextAniController = _midTabs[index]._animationController;
      _startAnim();
    } else {
      //滑动pageview
      _mTabController.animateTo(index);
      _currentAniController =
          _midTabs[_mTabController.previousIndex]._animationController;
      print(
          '_HomeState.onPageChange _mTabController,$index, ${_mTabController.previousIndex},p:$p');
      _nextAniController = _midTabs[index]._animationController;
      _startAnim();
    }
  }

  _buildTabs() {
    return _midTabs.map<Widget>((_midTab) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_midTab._title),
              Text(
                _midTab._subTitle,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Positioned(
            child: Container(
              height: 8,
              width: 16,
              child: ArcTransition(
                animation: _midTab._animationController,
                reverse: _initialAnim != _midTabs.indexOf(_midTab),
              ),
            ),
            bottom: 6,
          )
        ],
      );
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _currentAniController?.dispose();
    _nextAniController?.dispose();
    _animationController?.dispose();
    _context?.dispose();
  }

  void _startAnim() {
    print('_HomeState._startAnim ${_nextAniController.status}');
    if (_currentAniController == _midTabs[0]._animationController) {
      _currentAniController?.forward();
    } else {
      _currentAniController?.reverse();
    }
    if (_nextAniController == _midTabs[0]._animationController) {
      _nextAniController?.reverse();
    } else {
      _nextAniController?.forward();
    }
  }

  void _onPointerUp(PointerUpEvent event) {
//    print("_onPointerUp in $event");
    fling = true;
  }

  void _onPointerDown(PointerDownEvent event) {
//    print("_onPointerDown in $event");
    fling = false;
  }
}

///粘性头部具体代理类
class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CustomSliverPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
