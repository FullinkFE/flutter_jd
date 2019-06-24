import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_permissions/simple_permissions.dart';

/// 全局变量
final methodchannel = MethodChannel("android.fl.channel");

/// 年-月-日 时:分
getFormatTime() {
  var date = DateTime.now();
  String timestamp =
      "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
      "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  print("data time is $timestamp");
  return timestamp;
}

/// 显示底部弹框
/// [persistent] true:点击外围不消失
/// [child] 底部弹框显示的内容组件
showBottomDialog(BuildContext context,
    {bool persistent = false,
    transparent = false,
    GlobalKey<ScaffoldState> key,
    Widget child}) {
  assert(child != null);
  if (persistent) {
    assert(key != null);
    key.currentState.showBodyScrim(true, .5);
    key.currentState
        .showBottomSheet((BuildContext context) {
          return child;
        }, backgroundColor: transparent ? Colors.transparent : Colors.white)
        .closed
        .whenComplete(() {
          key.currentState.showBodyScrim(false, .5);
        });
  } else {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return child;
        },
        backgroundColor: transparent ? Colors.transparent : Colors.white);
  }
}

/// 调起打电话，外部网页打开链接等
launchItem(value) async {
////    const url = 'https://flutter.io';
//  const phone = 'tel:400-666-8888';
  if (await canLaunch(value)) {
    await launch(value);
  } else {
    throw 'Could not launch $value';
  }
}

/// 申请权限，如果已经授权则跳过
Future<bool> reqPermission(Permission permission) async {
  bool _auth = await SimplePermissions.checkPermission(permission);
  print("reqPermission in $_auth");
  if (!_auth) {
    PermissionStatus statusResult =
        await SimplePermissions.requestPermission(permission);
    return (statusResult == PermissionStatus.authorized);
  }
  return false;
}
