/*
 * @Author: caowencheng
 * @GitHub: https://github.com/cwc845982120
 * @Description: 详情页
 * @Date: 2019-07-16
 */

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/http/index.dart';
import 'package:flutter_app/actions/detailPage/operationAction.dart';
import 'package:flutter_app/utils/commonUtils.dart';
import 'package:flutter_app/components/display/pageLayout.dart';
import 'package:flutter_app/nativeLayer.dart';

class NavTestPage extends StatefulWidget {
  NavTestPage({this.params});

  Map<String, dynamic> params;

  @override
  _NavTestPageState createState() => new _NavTestPageState();
}

class _NavTestPageState extends State<NavTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new PageLayout(
        title: "Flutter Native communication Test",
        child: new Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text('原生页面入参 ：${widget.params.toString()}'),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  nativeLayer.nativePop();
                },
                child: new Text('返回原生,不带数据'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  var map = new Map<String, String>();
                  map["name"] = "hello flutter";
                  nativeLayer.nativePopResult(map);
                },
                child: new Text('返回原生,带返回数据'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  nativeLayer.nativeStart('nativeA');
                },
                child: new Text('打开原生页面，没有页面返回数据'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  var map = new Map<String, String>();
                  map["name"] = "hello flutter";
                  nativeLayer.nativeStart('nativeB',
                      requestCode: 100, arguments: map, callback: (args) {
                         CommonUtils.showToast("原生返回数据：${args.toString()}");
                      });
                },
                child: new Text('打开原生页面，有页面返回数据'),
              ),
            )
          ],
        ));
  }
}
