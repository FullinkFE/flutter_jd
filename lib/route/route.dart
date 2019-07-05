import 'package:flutter/material.dart';
import 'package:flutter_jd/page/CategoryPage.dart';
import 'package:flutter_jd/page/good_page.dart';

///所有路由集合
final Map routes = {
  "/category": (BuildContext context, {arguments}) => Category(),
  "/good": (BuildContext context, {arguments}) => Good(),
};
