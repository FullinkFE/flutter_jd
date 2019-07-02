import 'package:flutter/material.dart';
import 'package:flutter_jd/page/ShoppingBusPage.dart';
import 'package:quiver/iterables.dart';

class DiscoveryLove extends StatefulWidget {
  DiscoveryLove({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryLoveState createState() {
    return _DiscoveryLoveState();
  }
}

class _DiscoveryLoveState extends State<DiscoveryLove> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.scrollController(_scrollController);
    print("_DiscoveryLoveState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GridView.count(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          controller: _scrollController,
          children: range(20).map((_value) {
            return Center(
              child: Text("关注-item-$_value"),
              heightFactor: 2.0,
            );
          }).toList(),
        ),
      ],
    );
  }
}
