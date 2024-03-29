import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jd/page/discovery_collocation_page.dart';
import 'package:flutter_jd/page/discovery_fans_page.dart';
import 'package:flutter_jd/page/discovery_live_page.dart';
import 'package:flutter_jd/page/discovery_love_page.dart';
import 'package:flutter_jd/page/discovery_select_page.dart';
import 'package:flutter_jd/page/discovery_video_page.dart';

///发现首页
class Discovery extends StatefulWidget {
  @override
  _DiscoveryState createState() {
    return _DiscoveryState();
  }
}

class _DiscoveryState extends State<Discovery>
    with SingleTickerProviderStateMixin {
  final categories = ["关注", "精选", "粉丝价", "搭配", "直播", "视频"];
  var tabs = <Widget>[];
  var _index = 0;
  AnimationController _animationController;
  String value = "关注";

  var _headOpacity = 1.0;

  double _top = -1;

  @override
  void initState() {
    super.initState();
    initRes();
    print("_DiscoveryState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        //body内容
        NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 48),
            child: IndexedStack(
              index: _index,
              children: tabs.map((page) {
                return page;
              }).toList(),
            ),
          ),
        ),
        Positioned(
            left: 0,
            top: _animationController?.value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).padding.top + kToolbarHeight + 48,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //头部
                  Opacity(
                    opacity: _headOpacity,
                    child: Container(
                      height: kToolbarHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            child: IconButton(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                            left: 0,
                          ),
                          Text(
                            "发现",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Positioned(
                              right: 0,
                              child: Wrap(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.search,
                                          color: Colors.white),
                                      onPressed: null),
                                  IconButton(
                                      icon:
                                          Icon(Icons.chat, color: Colors.white),
                                      onPressed: () {}),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  //tab标签
                  Container(
                    height: 48,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: categories.map((value) {
                          return Expanded(
                              child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Wrap(
                              spacing: 3,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              direction: Axis.vertical,
                              children: <Widget>[
                                Text(value, textAlign: TextAlign.center),
                                this.value == value
                                    ? Container(
                                        height: 2,
                                        color: Colors.white,
                                        width: 20,
                                      )
                                    : SizedBox()
                              ],
                            ),
                            onTap: () {
                              this.value = value;
                              this._index = categories.indexOf(value);
                              setState(() {});
                              print("onTab tabed $value");
                            },
                          ));
                        }).toList()),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("resource/image/rect_bg.png"),
                      fit: BoxFit.cover)),
            )),
      ],
    );
  }

  /// 初始化动画监听和数据处理
  void initRes() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100),
        lowerBound: -48,
        upperBound: 0)
      ..addListener(() {
        //在自由滚动的时候，才进行setstate
        if (!fling) {
          return;
        }
        _top = _animationController.value;
        _headOpacity = (1 - _top.abs() / 48).clamp(0, 1).toDouble();
        setState(() {});
        print(
            "AnimationController listener in ${_animationController.value}，status:${_animationController.status},_animationController.isCompleted:${_animationController.isCompleted},_top:$_top");
      });
    _animationController.value = 0;

    tabs.addAll([
      DiscoveryLove(
        scrollController: getController,
      ),
      DiscoverySelect(
        scrollController: getController,
      ),
      DiscoveryFans(scrollController: getController),
      DiscoveryCollocation(scrollController: getController),
      DiscoveryLive(scrollController: getController),
      DiscoveryVideo(scrollController: getController),
    ]);
  }

  ScrollDirection _scrollDirection;
  bool fling = false;

  ///监听页面滚动
  bool _scrollListener(ScrollNotification notification) {
    var pixel = notification.metrics.pixels.floor();

    if (notification is ScrollUpdateNotification) {
      //向上/向下，已经滚动了指定距离
      if ((_top <= -48 && _scrollDirection == ScrollDirection.reverse) ||
          (_top >= 0 && _scrollDirection == ScrollDirection.forward) ||
          fling) {
        return true;
      }
      // 向上滚动
      if (_scrollDirection == ScrollDirection.reverse &&
          pixel <= notification.metrics.maxScrollExtent.floor()) {
        _top -= 1;
      }
      //向下滚动
      else if (_scrollDirection == ScrollDirection.forward && pixel >= 0) {
        _top += 1;
      }
      _headOpacity = (1 - _top.abs() / 48).clamp(0, 1).toDouble();
      _animationController.value = _top;
      print(
          "pixel is $pixel,_direction is $_scrollDirection,_top:$_top，_animationController.value：${_animationController.value}");
      setState(() {});
      return false;
    } else if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.idle) {
        return false;
      }
      _scrollDirection = notification.direction;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  bool isAnimating = false;

  ///开始动画
  void startAnim(ScrollDirection direction) {
    //不在自由滚动中或者已经滚动道目标位置，直接过滤掉
    if (!fling || _top <= -48 || _top >= 0) {
      return;
    }
    isAnimating = true;
    if (direction == ScrollDirection.forward) {
//      _animationController.reverse();
      _animationController.animateTo(0).whenComplete(() {
        _top = 0;
        isAnimating = false;
      });
    } else {
//      _animationController.forward();
      _animationController.animateTo(-48).whenComplete(() {
        _top = -48;
        isAnimating = false;
      });
    }
  }

  ///只作为监听fling滚动后执行动画
  void getController(ScrollController _scrollController) {
    _scrollController?.addListener(() {
      if (_scrollController.position.activity is BallisticScrollActivity) {
        fling = true;
        if (isAnimating) {
          return;
        }
        startAnim(_scrollDirection);
      } else {
        fling = false;
        isAnimating = false;
      }
    });
  }
}
