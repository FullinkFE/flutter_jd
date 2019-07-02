import 'package:flutter/material.dart';

class DiscoveryVideo extends StatefulWidget {
  @override
  _DiscoveryVideoState createState() {
    return _DiscoveryVideoState();
  }
}

class _DiscoveryVideoState extends State<DiscoveryVideo> {
  @override
  void initState() {
    super.initState();
    print("_DiscoveryVideoState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Text("视频");
  }
}
