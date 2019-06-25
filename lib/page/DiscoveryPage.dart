import 'package:flutter/material.dart';

class Discovery extends StatefulWidget {
  @override
  _DiscoveryState createState() {
    return _DiscoveryState();
  }

}

class _DiscoveryState extends State<Discovery> {
  @override
  void initState() {
    super.initState();
    print("_DiscoveryState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("发现"),
      ),
    );
  }

//  @override
//  bool get wantKeepAlive => true;
}
