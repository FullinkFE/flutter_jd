import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
///发现Tab页
class DiscoveryCollocation extends StatefulWidget {
  DiscoveryCollocation({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryCollocationState createState() {
    return _DiscoveryCollocationState();
  }
}

class _DiscoveryCollocationState extends State<DiscoveryCollocation> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.scrollController(_scrollController);
    print("DiscoveryCollocation initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
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
              child: Text("搭配-item-$_value"),
              heightFactor: 2.0,
            );
          }).toList(),
        ),
      ],
    );
  }
}
