import 'package:flutter/material.dart';

class DiscoveryLive extends StatefulWidget {
  @override
  _DiscoveryLiveState createState() {
    return _DiscoveryLiveState();
  }
}

class _DiscoveryLiveState extends State<DiscoveryLive> {
  @override
  void initState() {
    super.initState();
    print("_DiscoveryLiveState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Text("直播");
  }
}
