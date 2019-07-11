import 'package:flutter/material.dart';
import 'package:flutter_jd/widget/arc_transition.dart';

/// 创建时间：2019/7/10
/// 作者：95417
/// 描述：TODO
class TestPt extends StatefulWidget {
  TestPt({this.arguments});

  ///额外参数
  final arguments;

  @override
  State<StatefulWidget> createState() {
    return _TestPtState();
  }
}

class _TestPtState extends State<TestPt> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationController2;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            print(
                "animation in ${_animationController.value}-${_animationController.status}");
          });
    _animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            print(
                "animation in ${_animationController.value}-${_animationController.status}");
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text("测试arc动画"),
            onTap: () {
//              Navigator.pushNamed(context, "/testtb");
//              _animationController?.reset();
              if (_animationController.isCompleted) {
                _animationController?.reverse();
                _animationController2?.reverse();
              } else if (_animationController.isDismissed) {
                _animationController.forward();
                _animationController2.forward();
              }

              print('GestureDetector click in ${_animationController.status}');
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: ArcTransition(
                animation: _animationController,
              ),
              width: 100,
              height: 100,
            ),
            Container(
              child: ArcTransition(
                animation: _animationController2,
                reverse: true,
              ),
              width: 100,
              height: 100,
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _animationController2.dispose();
  }
}
