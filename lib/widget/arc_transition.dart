import 'dart:math';

import 'package:flutter/material.dart';

/// 创建时间：2019/7/10
/// 作者：95417
/// 描述：任意弧度动画组件
class ArcTransition extends StatelessWidget {
  ArcTransition({this.animation, this.reverse = false})
      : assert(animation != null);

  bool reverse;

  @required
  final Animation<double> animation;
  final Tween<double> _tween = Tween(begin: 0.0, end: pi);

  @override
  Widget build(BuildContext context) {
//    print('ArcTransition in ArcTransition');
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return CustomPaint(
            painter: _ArcPaint(
                constraints.maxWidth / 2,
                0,
                constraints.maxWidth / 2,
                reverse
                    ? pi - _tween.evaluate(animation)
                    : _tween.evaluate(animation)),
          );
        });
      },
    );
  }
}

class _ArcPaint extends CustomPainter {
  _ArcPaint(this._circleX, this._circleY, this._circleRadius, this._curAngel,
      {this.radiusWidth = 4})
      : assert(_circleX != null && _circleY != null && _circleRadius != null);

  Paint _paint = Paint();
  @required
  double _circleX;
  @required
  double _circleY;
  @required
  double _circleRadius;
  double _curAngel = 0.0;
  double radiusWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect2 = Rect.fromCircle(
        center: Offset(_circleX, _circleY), radius: _circleRadius);
    canvas.drawArc(
        rect2,
        pi,
        _curAngel - pi,
        false,
        _paint
          ..color = Colors.redAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = radiusWidth
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
