import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constUrl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:package_info/package_info.dart';
import 'package:toast/toast.dart';

class UpdateListTile extends StatefulWidget {
  @override
  UpdateListTileState createState() => UpdateListTileState();
}

class UpdateListTileState extends State<UpdateListTile> {
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersion();
  }

  // 执行更新APP的操作
  void updateApp() async {
    Response response = await new Dio().get(Constant.UPDATE);
    int versionCode =
        int.parse(jsonDecode(response.data)['VersionCode'].toString());
    print(versionCode);
    print(int.parse(buildNumber));
    if (versionCode > int.parse(buildNumber)) {
      FlutterXUpdate.checkUpdate(url: Constant.UPDATE);
    } else {
      Toast.show("当前已是最新版本" + buildNumber, context);
    }
  }

//版本信息
  void getVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text("检查更新"),
      subtitle: Text("当前版本：" + version),
      leading: Icon(AntDesign.info, color: Colors.blueAccent),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => updateApp(),
    );
  }
}
