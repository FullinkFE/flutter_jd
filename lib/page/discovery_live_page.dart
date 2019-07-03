import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class DiscoveryLive extends StatefulWidget {
  DiscoveryLive({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryLiveState createState() {
    return _DiscoveryLiveState();
  }
}

class _DiscoveryLiveState extends State<DiscoveryLive> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.scrollController(_scrollController);
    print("_DiscoveryLiveState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate(range(15).map((_num) {
          return Container(
            width: MediaQuery.of(context).size.width - 30,
            height: 48,
            child: Text("直播-$_num"),
          );
        }).toList()))
      ],
    );
  }
}
