import 'package:flutter/material.dart';

class ShoppingBus extends StatefulWidget {

  @override
  _ShoppingBusState createState() {
    return _ShoppingBusState();
  }
}

class _ShoppingBusState extends State<ShoppingBus> {
  @override
  void initState() {
    super.initState();
    print("_ShoppingBusState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("购物车"),
      ),
    );
  }

//  @override
//  bool get wantKeepAlive => true;
}
