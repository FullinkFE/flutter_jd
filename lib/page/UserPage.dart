import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {
  ScrollController _scrollController;
  double _headBgOpacity = .0;
  HitTestBehavior _curBehavior = HitTestBehavior.translucent;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        double _curPos = _scrollController.offset.round().toDouble();
        if (_curPos > 200) {
          return;
        }
        //更换事件透传模式
        if (_curPos + kToolbarHeight >= 200) {
//          _curBehavior = HitTestBehavior.translucent;
        }
        setState(() {
          _headBgOpacity = _curPos / 200;
        });
        print(
            "ScrollController addListener in : ${_scrollController.offset.round().toDouble()}\n${_headBgOpacity * 255}");
      });
    print("_UserState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    print("_UserState build in ");
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 180,
                padding: EdgeInsets.only(top: kToolbarHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Wrap(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: CircleAvatar(
                                child: Text(
                              "123",
                            )),
                          ),
                          Wrap(
                            spacing: 6,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Text("登陆/注册"),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                  )
                                ],
                              ),
                              Container(
                                height: 20,
                                width: 100,
                                color: Colors.greenAccent,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Toast.show("商品关注", context);
                                },
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Text("--"),
                                    Text("商品关注"),
                                  ],
                                ))),
                        Expanded(
                          child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Toast.show("店铺关注", context);
                              },
                              child: Wrap(
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  Text("--"),
                                  Text("店铺关注"),
                                ],
                              )),
                        ),
                        Expanded(
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Toast.show("喜欢的内容", context);
                                },
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Text("--"),
                                    Text("喜欢的内容"),
                                  ],
                                ))),
                        Expanded(
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Toast.show("浏览记录", context);
                                },
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Text("--"),
                                    Text("浏览记录"),
                                  ],
                                ))),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("resource/image/over_bg.png"),
                        fit: BoxFit.fill)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.yellowAccent,
                alignment: Alignment.center,
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width - 30) / 5,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        children: <Widget>[
                          Icon(Icons.directions),
                          Text("待处理-$index"),
                          Text(
                            index == 4 ? "查看电子发票" : "",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width - 50) / 4,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        children: <Widget>[
                          Icon(Icons.widgets),
                          Text("待处理-$index"),
                          Text(
                            index == 4 ? "查看电子发票" : "",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("工具与服务"),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Wrap(
                      children: "ABCDEFGH".split("").map((digit) {
                        return Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: (MediaQuery.of(context).size.width - 30) / 4,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Icon(Icons.widgets),
                              Text("待处理-$digit"),
                              Text(
                                digit == 'H' ? "更多" : "",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(heightFactor: 2.0,
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
          left: 0,
          top: 0,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.redAccent.withOpacity(_headBgOpacity),
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: kToolbarHeight,
                padding: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.redAccent.withOpacity(_headBgOpacity),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
//                        runAlignment: WrapAlignment.center,
//                        alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    Positioned(
                      child: Opacity(
                          opacity: _headBgOpacity,
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          )),
                      left: 0,
                    ),
                    Opacity(
                        opacity: _headBgOpacity,
                        child: Text(
                          "我的",
                          style: TextStyle(color: Colors.white),
                        )),
                    Positioned(
                        right: 0,
                        child: Wrap(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Toast.show("setting", context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.settings,
                                  color: Color.lerp(Colors.white, Colors.black,
                                      _headBgOpacity),
                                ),
                              ),
                            ),
                            Icon(Icons.message,
                                color: Color.lerp(Colors.black, Colors.white,
                                    _headBgOpacity)),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
