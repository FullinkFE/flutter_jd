import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

///发现-粉丝价
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
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
    );
  }
}
