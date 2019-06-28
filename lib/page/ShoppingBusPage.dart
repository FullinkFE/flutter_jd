import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Center(
                  heightFactor: 2.0,
                  child: Wrap(
                    children: <Widget>[Icon(Icons.last_page), Text("为你推荐")],
                  ),
                ),
              )
            ]
              ..addAll(("ABCDEFGHIJKLMNOPQRST").split("").map((value) {
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
            child: GestureDetector(child: _getFloatNavi(), onTap: () {
              _scrollController?.jumpTo(0);
            },),
            bottom: 60,
            right: 10,
          )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _getFloatNavi() {
    return CircleAvatar(
      child: Icon(Icons.arrow_upward),
    );
  }

  Widget _getBottomWidget() {
    return Container(
      height: 48,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
