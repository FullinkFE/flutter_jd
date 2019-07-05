import 'package:flutter/material.dart';
import 'package:flutter_jd/page/HomePage.dart';
import 'package:flutter_jd/widget/after_layout.dart';
import 'package:quiver/iterables.dart';

class ShoppingBus extends StatefulWidget {
  @override
  _ShoppingBusState createState() {
    return _ShoppingBusState();
  }
}

class _ShoppingBusState extends State<ShoppingBus> {
  var account = 0;
  var showDistance = 160;
  var show = false;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= showDistance) {
          if (show) {
            return;
          }
          setState(() {
            show = !show;
          });
        } else {
          if (!show) {
            return;
          }
          setState(() {
            show = !show;
          });
        }
      });
    print("_ShoppingBusState initState in ");
  }

  var tabStrs = "全部,降价,常买,分类";
  int index = 0;

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
//      appBar: AppBar(
//        title: Text("购物车"),
//        centerTitle: true,
//      ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: CustomSliverPersistentHeaderDelegate(
                    child: Container(
                        color: Colors.white,
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            Text("购物车"),
                            Icon(Icons.location_on)
                          ],
                        )),
                    minHeight: kToolbarHeight,
                    maxHeight: kToolbarHeight),
//                pinned: true,
                floating: true,
              ),
              SliverPersistentHeader(
                delegate: CustomSliverPersistentHeaderDelegate(
                    child: Container(
                      color: Colors.white,
                      child: Row(
                          children: tabStrs.split(",").map((_value) {
                        return Expanded(
                          child: GestureDetector(
                            child: Wrap(
                              runAlignment: WrapAlignment.center,
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Text(_value),
                                index == tabStrs.indexOf(_value)
                                    ? Container(
                                        width: 20,
                                        height: 4,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                          Colors.blueAccent,
                                          Colors.white
                                        ])),
                                      )
                                    : SizedBox()
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                index = tabStrs.indexOf(_value);
                              });
                            },
                          ),
                        );
                      }).toList()),
                    ),
                    minHeight: 36,
                    maxHeight: 36),
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed(range(20).map((_num) {
                return GestureDetector(
                  child: Card(
                    child: Text("商品-$_num"),
                  ),
                  onTap: () {
                    print("商品-$_num");
                    Navigator.pushNamed(context, "/good");
                  },
                );
              }).toList())),
              SliverToBoxAdapter(
                child: Center(
                  heightFactor: 2.0,
                  child: Wrap(
                    children: <Widget>[Icon(Icons.last_page), Text("为你推荐")],
                  ),
                ),
              )
            ]..addAll(("ABCDEFGHIJKLMNOPQRST").split("").map((value) {
                return SliverToBoxAdapter(
                  child: ListTile(
                    title: Text("child-$value"),
                  ),
                );
              })),
          ),
          Positioned(
            child: _getBottomWidget(),
            bottom: 0,
            left: 0,
          ),
          show
              ? Positioned(
                  child: GestureDetector(
                    child: getFloatNavi(),
                    onTap: () {
                      _scrollController?.jumpTo(0);
                      print(
                          "head is : ${MediaQuery.of(context).padding.top},$kToolbarHeight}");
                    },
                  ),
                  bottom: 60,
                  right: 10,
                )
              : SizedBox(),
        ],
      )),
    );
  }

  Widget _getBottomWidget() {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: <Widget>[
          Wrap(
            spacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Icon(Icons.airline_seat_legroom_reduced),
              Text("全选"),
              Text("合计："),
              Text("￥0.00"),
            ],
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              onPressed: () {},
              color: Colors.redAccent,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    "去结算",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text("($account)", style: TextStyle(color: Colors.white)),
                ],
              ))
        ],
      ),
    );
  }
}

Widget getFloatNavi() {
  return CircleAvatar(
    child: Icon(Icons.arrow_upward),
  );
}
