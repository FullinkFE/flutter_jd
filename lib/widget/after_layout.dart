import 'package:flutter/material.dart';

typedef onAfterCallBack = void Function(BuildContext context);

///加载完成后回调组件
class AfterLayout extends StatelessWidget {
  AfterLayout({Key key, this.child, this.onAfter, this.offset})
      : super(key: key);

  final Widget child;

  final onAfterCallBack onAfter;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return onAfter(context);
    });
    return child;
  }
}
