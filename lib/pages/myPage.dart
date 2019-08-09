/*
 * @Author: caowencheng
 * @GitHub: https://github.com/cwc845982120
 * @Description: 我的
 * @Date: 2019-07-16
 */

import 'package:flutter_app/eventbus/bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/display/pageLayout.dart';
import 'package:flutter_app/components/bussiness/common/animView.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _ContentPage();
  }
}

class _ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentPageState();
  }
}

class _ContentPageState extends State<_ContentPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
//    wait();
  }

  Future<Null> wait() async {
    await Future.delayed(Duration(seconds: 3), () {
      AnimViewFactory.start("key");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new PageLayout(
      title: "我的",
//      child: ListView.builder(
//
//        itemBuilder: (BuildContext context, int index) {
//          return AnimViewFactory.createView(
//              key: "key",
//              tightW: 100,
//              tightH: 20,
//              child: Text("111111111111"),
//              state: this);
//        },
//        itemCount: 100,
//      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    AnimViewFactory.start("key");
                  },
                  child: Text("开始"),
                ),
                RaisedButton(
                  onPressed: () {
                    AnimViewFactory.stop("key");
                  },
                  child: Text("结束"),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return AnimViewFactory.createView(
                    key: "key",
                    tightW: 30,
                    tightH: 20,
                    child: Text("111111111111"),
                    state: this);
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    AnimViewFactory.dispose("key");
  }
}
