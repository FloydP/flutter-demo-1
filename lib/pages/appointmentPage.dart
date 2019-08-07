/*
 * @Author: caowencheng
 * @GitHub: https://github.com/cwc845982120
 * @Description: 预约页
 * @Date: 2019-07-16
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/components/display/pageLayout.dart';
import 'package:flutter_app/components/bussiness/appointmentPage/filter.dart';
import 'package:flutter_app/components/bussiness/appointmentPage/listItem.dart';
import 'package:flutter_app/components/bussiness/common/animView.dart';
import 'package:flutter_app/components/bussiness/common/rootView.dart';

class AppointmentPage extends StatefulWidget {
  final List<FilterCondition> filterConditions = [
    new FilterCondition(name: "待上课", id: 0x1),
    new FilterCondition(name: "已评价", id: 0x2),
    new FilterCondition(name: "已完成", id: 0x3),
    new FilterCondition(name: "已退课", id: 0x4),
  ];

  @override
  _AppointmentPageState createState() => new _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RootView rootView;

  @override
  void initState() {
    super.initState();
    setView();
  }

  Future<Null> start() async {
    await Future.delayed(Duration(seconds: 3), () {
      AnimViewFactory.start("list");
    });
  }

  Future<Null> stop() async {
    await Future.delayed(Duration(seconds: 3), () {
      AnimViewFactory.stop("list");
    });
  }

  Future<Null> setView() async {
    await Future.delayed(Duration(seconds: 3), () {
      rootView.show(ViewState.error);
    });
  }

  Widget _buildRootView() {
    rootView = RootView(
      errorRefreshTap: () {
        rootView.show(ViewState.normal);
      },
      child: new Column(
        children: <Widget>[
          new FilterView(
            callback: (pos, condition) {
              AnimViewFactory.start("list");
              stop();
            },
            data: widget.filterConditions,
            currentIndex: 0,
          ),
          new Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10.0),
              itemBuilder: (BuildContext context, int index) {
                return ListItemView();
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 10,
                  color: Color(0xF4F4F4),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
    return rootView;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new PageLayout(
      title: "预约",
      child: _buildRootView(),
    );
  }
}
