import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

///发现-精选
class DiscoverySelect extends StatefulWidget {
  DiscoverySelect({this.scrollController});

  final Function scrollController;

  @override
  _DiscoverySelectState createState() {
    return _DiscoverySelectState();
  }
}

class _DiscoverySelectState extends State<DiscoverySelect> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    widget.scrollController(_scrollController);
    print("_DiscoverySelectState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      controller: _scrollController,
      children: range(20).map((_value) {
        return Center(
          child: Text("精选-item-$_value"),
          heightFactor: 2.0,
        );
      }).toList(),
    );
  }
}
