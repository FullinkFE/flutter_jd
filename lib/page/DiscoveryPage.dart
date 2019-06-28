import 'package:flutter/material.dart';

class Discovery extends StatefulWidget {
  @override
  _DiscoveryState createState() {
    return _DiscoveryState();
  }
}

class _DiscoveryState extends State<Discovery> {
  String _progress = "0%"; //保存进度百分比
  @override
  void initState() {
    super.initState();
    print("_DiscoveryState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return CustomScrollView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Text("5555"),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            child: NotificationListener<ScrollNotification>(
              onNotification: _scrollListener,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: 100,
                      itemExtent: 50.0,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text("$index"));
                      }),
                  CircleAvatar(
                    //显示进度百分比
                    radius: 30.0,
                    child: Text(_progress),
                    backgroundColor: Colors.black54,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

//  @override
//  bool get wantKeepAlive => true;

  bool _scrollListener(ScrollNotification notification) {
    double progress =
        notification.metrics.pixels / notification.metrics.maxScrollExtent;
    //重新构建
    setState(() {
      _progress = "${(progress * 100).toInt()}%";
    });
    print("BottomEdge: ${notification.metrics.extentAfter == 0}");
//          return true; //放开此行注释后，进度条将失效
  }
}
