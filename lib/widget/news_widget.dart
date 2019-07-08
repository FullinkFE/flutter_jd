import 'dart:math';

import 'package:flutter/material.dart';

enum OutlineStyle {
  ///原型边框
  circle,

  ///圆角边框
  rect,

  /// 实型背景
  none
}

/// 维度消息简单装置组件
class NewsWidget extends StatefulWidget {
  ///右上角消息数量
  final num newsCount;

  ///高度
  final double height;

  ///宽度
  final double width;

  /// 主题小图标
  final Widget newsIcon;

  ///主题文字
  final String newsTitle;

  /// 边框样式，默认圆形边框
  final OutlineStyle outlineStyle;

  /// 背景颜色，默认透明
  final Color backgroundColor;

  /// 主题颜色，包括边框和字体颜色
  final Color primaryColor;

  NewsWidget(
      {this.newsCount,
      this.width = 48,
      this.height = 48,
      @required this.newsIcon,
      this.newsTitle,
      this.outlineStyle = OutlineStyle.rect,
      this.backgroundColor = Colors.white,
      this.primaryColor = Colors.redAccent})
      : assert(newsIcon != null);

  @override
  State<StatefulWidget> createState() {
    return _NewsWidgetState();
  }
}

class _NewsWidgetState extends State<NewsWidget> {
  double _countSize;
  double _countRadius;

  @override
  void initState() {
    super.initState();
    initParam();
  }

  void initParam() {
    _countSize = widget.width / 3;
    switch (widget.outlineStyle) {
      case OutlineStyle.circle:
        _countRadius = _countSize / 2;
        break;
      case OutlineStyle.rect:
        _countRadius = 2;
        break;
      case OutlineStyle.none:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
//    return SizedBox(
//        width: widget.width,
//        height: widget.height,
//        child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              Container(
//                alignment: Alignment.topRight,
//                child: Stack(
//                  alignment: Alignment.topRight,
//                  children: <Widget>[
//                    Container(
//                      width: 20,
//                      height: 20,
//                      alignment: Alignment.center,
//                      decoration: ShapeDecoration(
//                          color: Colors.white,
//                          shape: CircleBorder(
//                              side: BorderSide(color: widget.primaryColor))),
//                    ),
//                    Text(
//                      "444",
//                      style: TextStyle(fontSize: 12),
//                    ),
//                  ],
//                ),
//                decoration: BoxDecoration(
////                    border: Border.all(color: widget.primaryColor),
//                    image: DecorationImage(
//                        image: AssetImage("resource/image/icon_bill.png"))),
//              ),
////          widget.newsIcon,
//              widget.newsTitle == null
//                  ? SizedBox()
//                  : Text(
//                      widget.newsTitle,
//                      style: TextStyle(fontSize: 12),
//                    ),
//            ]));

    return SizedBox(
//      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.newsIcon,
              widget.newsTitle == null
                  ? SizedBox()
                  : Text(
                      widget.newsTitle,
                      style: TextStyle(fontSize: 12),
                    ),
            ],
          ),
          widget.newsCount == null
              ? SizedBox()
              : Positioned(
                  child: widget.outlineStyle == OutlineStyle.none
                      ? Container(
//                          width: _countSize,
                          height: _countSize,
                          color: Colors.white,
                          child: Text(
                            widget.newsCount.toString(),
                            style: TextStyle(color: widget.primaryColor),
                          ))
                      : Container(
//                          width: _countSize,
//                          height: _countSize,
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          alignment: Alignment.center,
                          child: Text(
                            widget.newsCount.toString().length >= 3
                                ? widget.newsCount.toString().substring(0, 2) +
                                    "+"
                                : widget.newsCount.toString(),
                            style: TextStyle(
                                color: widget.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),

//                          decoration: ShapeDecoration(
//                              color: Colors.white,
//                              shape: CircleBorder(
//                                  side:
//                                      BorderSide(color: widget.primaryColor))),
                          decoration: widget.newsCount.toString().length >= 2
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(_countSize / 2),
                                  border:
                                      Border.all(color: widget.primaryColor))
                              : ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          color: widget.primaryColor))),
                        ),
                  right: 0,
                  top: 0,
                ),
        ],
      ),
    );
  }
}
