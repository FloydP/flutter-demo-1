/*
 * @Author: caowencheng
 * @GitHub: https://github.com/cwc845982120
 * @Description: 路由处理 工具函数
 * @Date: 2019-07-16
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/components/display/bottomTabBar.dart';
import 'package:flutter_app/pages/detailPage.dart';
import 'package:flutter_app/pages/studioList.dart';
import 'package:flutter_app/pages/nativeTestPage.dart';

enum Routes {
  homePage,
  studioList,
  detailPage,
  appointmentPage,
  myPage,
  nativeTest,
}

class RouterUtils {
  static Widget getRouterWidgetByName(String route, {Map params}) {
    switch (getRouteClass(route)) {
      case Routes.homePage:
        return new BottomTabBar(currentIndex: 0);
      case Routes.studioList:
        return new StudioList(params: params);
      case Routes.detailPage:
        return new DetailPage(params: params);
      case Routes.appointmentPage:
        return new BottomTabBar(currentIndex: 1);
      case Routes.myPage:
        return new BottomTabBar(currentIndex: 2);
      case Routes.studioList:
        return new BottomTabBar(currentIndex: 2);
      case Routes.nativeTest:
        return new NavTestPage(params: params);
      default:
        return new BottomTabBar(currentIndex: 0);
    }
  }

  static Routes getRouteClass(String route) {
    switch (route) {
      case "/":
        return Routes.homePage;
      case "home":
        return Routes.appointmentPage;
      case "nativeTest":
        return Routes.nativeTest;
      default:
        return Routes.homePage;
    }
  }

  /*
	获取路由页面实例
	 */
  static MaterialPageRoute getRouteByName(Routes routeName, {Map params}) {
    return new MaterialPageRoute(builder: (BuildContext context) {
      switch (routeName) {
        case Routes.homePage:
          return new BottomTabBar(currentIndex: 0);
        case Routes.studioList:
          return new StudioList(params: params);
        case Routes.detailPage:
          return new DetailPage(params: params);
        case Routes.appointmentPage:
          return new BottomTabBar(currentIndex: 1);
        case Routes.myPage:
          return new BottomTabBar(currentIndex: 2);
        default:
          return new BottomTabBar(currentIndex: 0);
      }
    });
  }

  /*
	获取路由页面名称
	 */
  static String getRouteName(Routes routeName) {
    switch (routeName) {
      case Routes.homePage:
        return "/homePage";
      case Routes.studioList:
        return "/studioList";
      case Routes.detailPage:
        return "/detailPage";
      case Routes.appointmentPage:
        return "/appointmentPage";
      case Routes.myPage:
        return "/mypage";
      default:
        return "/homePage";
    }
  }

  /*
	页面前进
	 */
  static void push(BuildContext context, Routes routeName,
      {Map params = const {}}) {
    Navigator.push(context, getRouteByName(routeName, params: params));
  }

  /*
	页面前进 根据路由名称
	 */
  static void pushNamed(BuildContext context, Routes routeName) {
    Navigator.pushNamed(context, getRouteName(routeName));
  }

  /*
	页面后退
	 */
  static void pop(BuildContext context, {Map result}) {
    Navigator.pop(context, result);
  }

  /*
	页面清栈 并跳转到指定页
	 */
  static void pushAndRemoveUntil(BuildContext context, Routes routeName,
      {Map params}) {
    Navigator.pushAndRemoveUntil(
        context,
        getRouteByName(routeName, params: params),
        ModalRoute.withName(getRouteName(routeName)));
  }

  /*
	页面清栈 并根据名称跳转到指定页
	 */
  static void pushNamedAndRemoveUntil(BuildContext context, Routes routeName,
      {Map params}) {
    Navigator.pushNamedAndRemoveUntil(context, getRouteName(routeName),
        ModalRoute.withName(getRouteName(routeName)));
  }
}
