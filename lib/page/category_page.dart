import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jd/util/constants.dart';
import 'package:flutter_jd/widget/after_layout.dart';

///分类Tab页
class Category extends StatefulWidget {
  @override
  _CategoryState createState() {
    return _CategoryState();
  }
}

/// 分类数据源封装
class _CateItem {
  var _title;

  List<_GoodItem> _goodItems;

  _CateItem(this._title, this._goodItems);
}

/// 分类数据源封装
class _GoodItem {
  final Icon _icon;
  final String _iconName;

  _GoodItem(this._icon, this._iconName);
}

class _CategoryState extends State<Category> {
  GlobalKey _key = GlobalKey();
  ScrollController _scrollController;
  int _index = 0;
  List<_CateItem> datas = [];

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
    print("_CategoryState initState in ");
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AfterLayout(
                child: Icon(Icons.scanner),
                onAfter: (context) {},
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: <Widget>[
                    Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[Icon(Icons.search), Text("沐浴露")],
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )
                  ],
                ),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: colorGreyFF939BAC),
              )),
              Center(
                child: Icon(Icons.chat),
              )
            ],
          ),
        ),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
//                    return Text("分类-$index");
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        color: _index == index
                            ? Colors.white
                            : Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            _index == index ? _getRectIndicator() : SizedBox(),
                            Text("热门分类-$index")
                          ],
                        ),
                      ),
                      onTap: () {
                        showLoading = !showLoading;
                        _getData();
                        setState(() {
                          _index = index;
                        });
                      },
                    );
                  },
                  itemCount: 50,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: showLoading
                      ? _getLoadingWidget()
                      : Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: CustomScrollView(
                            shrinkWrap: true,
                            controller: _scrollController,
                            physics: BouncingScrollPhysics(),
                            slivers: <Widget>[
                              SliverToBoxAdapter(
                                child: Image.asset(
                                  "resource/image/over_bg.png",
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ]..addAll(datas.map((_item) {
                                return SliverToBoxAdapter(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(_item._title),
                                        heightFactor: 2.0,
                                      ),
                                      GridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 3,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: _item._goodItems.map((_good) {
                                          return Text(
                                              _item._title + _good._iconName);
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                );
                              })),
                          ),
                        ))
            ],
          ),
        )
      ],
    );
  }

  ///模拟异步获取数据
  _getData() async {
    datas.clear();
    Future.delayed(Duration(milliseconds: 800), () {
      var childs = [
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱1"),
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱2"),
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱3"),
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱4"),
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱5"),
        _GoodItem(Icon(Icons.sync_problem), "拉杆箱6"),
      ];
      var childs2 = [
        _GoodItem(Icon(Icons.sync_problem), "精品男包1"),
        _GoodItem(Icon(Icons.sync_problem), "精品男包2"),
        _GoodItem(Icon(Icons.sync_problem), "精品男包3"),
        _GoodItem(Icon(Icons.sync_problem), "精品男包4"),
        _GoodItem(Icon(Icons.sync_problem), "精品男包5"),
        _GoodItem(Icon(Icons.sync_problem), "精品男包6"),
      ];
      datas.add(
        _CateItem("热门分类", childs),
      );
      datas.add(
        _CateItem("流行男鞋", childs2),
      );
      showLoading = false;
      setState(() {});
    });
  }

  /// 获取正在加载组件
  Widget _getLoadingWidget() {
    return Center(
      child: Wrap(
        spacing: 2.0,
        direction: Axis.vertical,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
          Text("加载中...")
        ],
      ),
    );
  }

  _getRectIndicator() {
    return Container(
      width: 2,
      margin: EdgeInsets.only(left: 2),
      height: 10,
      color: Colors.redAccent,
    );
  }
}
