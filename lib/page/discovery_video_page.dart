import 'package:flutter/material.dart';
import 'package:flutter_jd/page/ShoppingBusPage.dart';
import 'package:quiver/iterables.dart';

class DiscoveryVideo extends StatefulWidget {
  DiscoveryVideo({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryVideoState createState() {
    return _DiscoveryVideoState();
  }
}

class _DiscoveryVideoState extends State<DiscoveryVideo> {
  ScrollController _scrollController;

  var show = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        //控制右下角箭头显示
        if (_scrollController.position.pixels >= 150) {
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
    widget.scrollController(_scrollController);
    print("_DiscoveryVideoState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
            controller: _scrollController,
            children: range(16).map<Widget>((_num) {
              return Center(
                heightFactor: 3,
                child: Text("视频-$_num"),
              );
            }).toList()),
        show
            ? Positioned(
                child: GestureDetector(
                  child: getFloatNavi(),
                  onTap: () {
                    _scrollController?.jumpTo(
                        MediaQuery.of(context).padding.top + kToolbarHeight);
                  },
                ),
                bottom: 40,
                right: 16,
              )
            : SizedBox()
      ],
    );
  }
}
