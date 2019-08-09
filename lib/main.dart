/*
 * @Author: caowencheng
 * @GitHub: https://github.com/cwc845982120
 * @Description: main 主函数
 * @Date: 2019-07-16
 */

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/model/nativeRouter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/utils/routerUtils.dart';
import 'package:flutter_app/utils/logUtils.dart';
import 'package:flutter_app/config/index.dart';
import 'package:flutter_app/store.dart';
import 'package:flutter_app/components/display/globalContext.dart';
import 'package:flutter_app/components/display/bottomTabBar.dart';
import 'package:flutter_app/pages/detailPage.dart';
import 'package:flutter_app/pages/studioList.dart';
import 'package:flutter_app/pages/nativeTestPage.dart';

class AppComponent extends StatelessWidget {
  AppComponent({this.router});

  /*
   * 初始化路由跳转
   */
  final String router;

  /*
   * 初始化redux store
   */
  final Store store = createStore();

  Widget _getRouterWidget() {
    var nativeRouter = NativeRouter.fromJson(json.decode(router));
    return RouterUtils.getRouterWidgetByName(nativeRouter.route,
        params: nativeRouter.arguments);
  }

  @override
  Widget build(BuildContext context) {
    LogUtils.init(isDebug: (mode != 3));

    return new StoreProvider(
        store: store,
        child: GlobalContext(
            child: new MaterialApp(
              title: 'Flutter App',
              debugShowCheckedModeBanner: false,
              home: _getRouterWidget(),
              routes: <String, WidgetBuilder>{
                '/homePage': (BuildContext context) =>
                new BottomTabBar(currentIndex: 0),
                '/studioList': (BuildContext context) => new StudioList(),
                '/detailPage': (BuildContext context) => new DetailPage(),
                '/appointmentPage': (BuildContext context) =>
                new BottomTabBar(currentIndex: 1),
                '/myPage': (BuildContext context) =>
                new BottomTabBar(currentIndex: 2),
                '/nativeTestPage' :
                (BuildContext context) => new NavTestPage()
              },
            )));
  }
}

void main() => runApp(new AppComponent(router: window.defaultRouteName));
