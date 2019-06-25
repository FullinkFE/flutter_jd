import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {
  @override
  void initState() {
    super.initState();
    print("_UserState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    print("_UserState build in ");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("我的"),
      ),
    );
  }
}
