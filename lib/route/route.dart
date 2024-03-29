import 'package:flutter/material.dart';
import 'package:flutter_jd/page/TestPaint.dart';
import 'package:flutter_jd/page/TestTab.dart';
import 'package:flutter_jd/page/category_page.dart';
import 'package:flutter_jd/page/good_page.dart';

///所有路由集合
final Map routes = {
  "/category": (BuildContext context, {arguments}) => Category(),
  "/good": (BuildContext context, {arguments}) => Good(),
  "/testpt": (BuildContext context, {arguments}) => TestPt(),
  "/testtb": (BuildContext context, {arguments}) => TestTb(),
};
