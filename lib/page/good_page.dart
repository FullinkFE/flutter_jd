import 'package:flutter/material.dart';
import 'package:flutter_jd/util/constants.dart';
import 'package:quiver/iterables.dart';
import 'package:toast/toast.dart';

///商品首页-待完善
class Good extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodState();
  }
}

class _GoodState extends State<Good> {
  double _headBgOpacity = 1.0;
  int _distance = 100;
  ScrollController _scrollController;

  var tabStrs = "商品,详情,评价,推荐";

  var index = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        var position = _scrollController.position.pixels.toInt();
        _headBgOpacity = (position / _distance).clamp(0, 1).toDouble();
        print("listener in: $position,$_headBgOpacity");
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate.fixed(range(40).map((_num) {
                return GestureDetector(
                  child: Card(
                    child: Text("商品-$_num"),
                  ),
                  onTap: () {
                    print("商品-$_num");
                    Navigator.pushNamed(context, "/good");
                  },
                );
              }).toList()))
            ],
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Column(
              children: <Widget>[
                Container(
                  height: kToolbarHeight,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white.withOpacity(_headBgOpacity),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
//                        runAlignment: WrapAlignment.center,
//                        alignment: WrapAlignment.spaceBetween,
                    children: <Widget>[
                      Positioned(
                        child: CircleAvatar(
                          maxRadius: 16,
                          backgroundColor:
                              colorGreyFF687188.withOpacity(1 - _headBgOpacity),
                          child: IconButton(
                            alignment: Alignment.center,
                            iconSize: 16,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color.lerp(
                                  Colors.white, Colors.black, _headBgOpacity),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        left: 0,
                      ),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: tabStrs.split(",").map((_value) {
                              return GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(
                                                color: Colors.black.withOpacity(
                                                    _headBgOpacity)),
                                      ),
                                      index == tabStrs.indexOf(_value)
                                          ? Container(
                                              width: 20,
                                              height: 4,
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
                                                Colors.blueAccent.withOpacity(
                                                    _headBgOpacity),
                                                Colors.white
                                                    .withOpacity(_headBgOpacity)
                                              ])),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    index = tabStrs.indexOf(_value);
                                  });
                                },
                              );
                            }).toList()),
                      ),
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
                                  child: CircleAvatar(
                                      maxRadius: 16,
                                      backgroundColor: colorGreyFF687188
                                          .withOpacity(1 - _headBgOpacity),
                                      child: IconButton(
                                        alignment: Alignment.center,
                                        iconSize: 16,
                                        icon: Icon(
                                          Icons.share,
                                          color: Color.lerp(Colors.white,
                                              Colors.black, _headBgOpacity),
                                        ),
                                        onPressed: () {},
                                      )),
                                ),
                              ),
                              CircleAvatar(
                                  maxRadius: 16,
                                  backgroundColor: colorGreyFF687188
                                      .withOpacity(1 - _headBgOpacity),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: 16,
                                    icon: Icon(
                                      Icons.dehaze,
                                      color: Color.lerp(Colors.white,
                                          Colors.black, _headBgOpacity),
                                    ),
                                    onPressed: () {},
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
