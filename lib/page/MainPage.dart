import 'package:flutter/material.dart';
import 'package:flutter_jd/page/CategoryPage.dart';
import 'package:flutter_jd/page/DiscoveryPage.dart';
import 'package:flutter_jd/page/HomePage.dart';
import 'package:flutter_jd/page/ShoppingBusPage.dart';
import 'package:flutter_jd/page/UserPage.dart';

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<Main> {
  final tabs = [
    _TabItem(Icon(Icons.home), "首页", Home()),
    _TabItem(Icon(Icons.category), "分类", Category()),
    _TabItem(Icon(Icons.find_in_page), "发现", Discovery()),
    _TabItem(Icon(Icons.shopping_cart), "购物车", ShoppingBus()),
    _TabItem(Icon(Icons.account_box), "我的", User()),
  ];
  var _index = 0;

  @override
  void initState() {
    super.initState();
//    _getTabs().then((items) {
//      print("656666 $items");
////      setState(() {
////        tabs = items;
////      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: tabs.map((_item) {
          return Offstage(
            child: _item._page,
            offstage: tabs.indexOf(_item) != _index,
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs.map((_TabItem item) {
          return BottomNavigationBarItem(
              icon: item._icon, title: Text(item._name));
        }).toList(),
        currentIndex: _index,
        onTap: onTabClick,
        type: BottomNavigationBarType.fixed,
//        fixedColor: Colors.redAccent,
      ),
    );
  }

  ///tab点击事件
  void onTabClick(int value) {
    print("BottomNavigationBarItem onTabClick $value");
    setState(() {
      _index = value;
    });
  }
}

Future<List<_TabItem>> _getTabs() {
  return Future.delayed(Duration(seconds: 2), () {
    var _tabs = [
      _TabItem(Icon(Icons.home), "首页", Home()),
      _TabItem(Icon(Icons.category), "分类", Category()),
      _TabItem(Icon(Icons.find_in_page), "发现", Discovery()),
      _TabItem(Icon(Icons.shopping_cart), "购物车", ShoppingBus()),
      _TabItem(Icon(Icons.account_box), "我的", User()),
    ];
    return _tabs;
  });
}

class _TabItem {
  final Icon _icon;
  final String _name;
  final Widget _page;

  _TabItem(this._icon, this._name, this._page);
}

class _KeyPage {
  final PageStorageKey<_TabItem> _storageKey;
  final Widget _page;

  _KeyPage(this._storageKey, this._page);
}
