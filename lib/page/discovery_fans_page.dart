import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class DiscoveryFans extends StatefulWidget {
  DiscoveryFans({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryFansState createState() {
    return _DiscoveryFansState();
  }
}

class _DiscoveryFansState extends State<DiscoveryFans> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.scrollController(_scrollController);
    print("DiscoveryFans initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
//            fit: StackFit.expand,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        margin: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("resource/image/rect_bg.png"),
                                fit: BoxFit.cover)),
//                      child: Column(
//                        children: <Widget>[
//                          Image.asset("resource/image/rect_bg.png",
//                              width: MediaQuery.of(context).size.width,
//                              height: 250,
//                              fit: BoxFit.cover)
//                        ],
//                      ),
                      ),
                      left: 0,
                      top: 0,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Positioned(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset("resource/image/rect_bg.png",
                            fit: BoxFit.cover),
                      ),
                      left: 0,
                      top: 0,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
//      children: range(16).map((_num) {
//        return Center(
//          heightFactor:3,
//          child: Text("粉丝价-$_num"),
//        );
//      }).toList(),
    );
  }
//
//  final GlobalKey key = new GlobalKey();
//
//  void onTapDown(BuildContext context, TapDownDetails details) {
//    final RenderBox box = context.findRenderObject();
//    final Offset localOffset = box.globalToLocal(details.globalPosition);
//    final RenderBox containerBox = key.currentContext.findRenderObject();
//    final onTap = containerBox.paintBounds.contains(localOffset);
//    print(
//        "localOffset：$localOffset,paintBounds：${containerBox.paintBounds},$localOffset,$onTap");
//    if (onTap) {
//      print("DO YOUR STUFF...");
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      behavior: HitTestBehavior.opaque,
//      onTapDown: (TapDownDetails details) => onTapDown(context, details),
//      child: Container(
//        color: Colors.red,
//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
//        child: Align(
//          alignment: Alignment.topLeft,
//          child: SizedBox(
//            width: 200.0,
//            height: 400.0,
//            child: Container(
//              color: Colors.black,
//              child: Stack(
//                overflow: Overflow.visible,
//                children: [
//                  Positioned(
//                    top: 0.0,
//                    left: 0.0,
//                    child: Container(
//                      key: key,
//                      width: 500.0,
//                      height: 200.0,
//                      color: Colors.blue,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
}
