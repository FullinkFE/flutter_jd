import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/util/Constants.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiver/iterables.dart';
import 'dart:math' as math;

class _CategoryItem {
  final Icon _icon;
  final String _text;

  _CategoryItem(this._icon, this._text);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ScrollController _scrollController;

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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    print("_HomeState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.red));
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Icon(Icons.hourglass_empty),
                            Text("京东")
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: <Widget>[
                                Icon(Icons.settings_overscan),
                                Text(
                                  "扫啊扫",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: <Widget>[
                                Icon(Icons.message),
                                Text(
                                  "消息",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
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
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.redAccent),
                    ),
                    Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightBlueAccent,
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
                pagination: new SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                    BorderRadius.circular(10),
                                                color: Colors.redAccent),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Text(
                                              "00.00.23",
                                              style: TextStyle(fontSize: 12),
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
                                                  BorderRadius.circular(10))),
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
                                                    TextDecorationStyle.solid,
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
                                                    TextDecorationStyle.solid,
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
                                                    TextDecorationStyle.solid,
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
                                padding: EdgeInsets.all(10),
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
                                itemBuilder: (BuildContext context, int index) {
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
                    color: Colors.yellowAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.pinkAccent,
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
                                color: Colors.redAccent,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  crossAxisAlignment: WrapCrossAlignment.center,
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
              delegate: _CustomSliverPersistentHeaderDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.redAccent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.yellowAccent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.greenAccent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  )),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Text("ooo-$index");
            }, childCount: 40)),
          ],
        ),
      ),
    );
  }

  var imgs = [
    "https://img4.mukewang.com/szimg/59b8a486000107fb05400300.jpg",
    "https://img3.mukewang.com/szimg/5a7127370001a8fa05400300.jpg",
    "https://img4.mukewang.com/szimg/5c18d2d8000141c506000338.jpg"
  ];

  //每页数据是10条
  int _categoryCount = 10;

  Widget _buildCategory(int index) {
    range(3);
    List tempLists = [];
//    var i = categories.length >= (index + 1) * everyCount
//        ? everyCount - 1
//        : index * everyCount +
//            categories.sublist(index * everyCount).length -
//            1;

    tempLists = categories
        .getRange(
            index * _categoryCount,
            categories.length >= (index + 1) * _categoryCount
                ? _categoryCount
                : index * _categoryCount +
                    categories.sublist(index * _categoryCount).length)
        .toList();
    print("get out $index,tempLists is ${tempLists.length}");
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

//  @override
//  bool get wantKeepAlive => true;
}

class _CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  _CustomSliverPersistentHeaderDelegate({
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
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_CustomSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
