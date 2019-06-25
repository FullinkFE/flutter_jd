import 'package:flutter/material.dart';

class Category extends StatefulWidget {

  @override
  _CategoryState createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    print("_CategoryState initState in ");
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("分类"),
      ),
    );
  }

//  @override
//  bool get wantKeepAlive => true;
}
