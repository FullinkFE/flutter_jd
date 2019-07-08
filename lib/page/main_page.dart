import 'package:flutter/material.dart';
import 'package:flutter_jd/page/category_page.dart';
import 'package:flutter_jd/page/discovery_page.dart';
import 'package:flutter_jd/page/home_page.dart';
import 'package:flutter_jd/page/shoppingbus_page.dart';
import 'package:flutter_jd/page/user_page.dart';

///tab页启动容器，显示底部tab项
class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<Main> {
  //底部tab+页面数据
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

///tab+page
class _TabItem {
  final Icon _icon;
  final String _name;
  final Widget _page;

  _TabItem(this._icon, this._name, this._page);
}
