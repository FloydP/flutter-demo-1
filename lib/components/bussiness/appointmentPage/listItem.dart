import 'package:flutter/material.dart';
import 'package:flutter_app/components/bussiness/common/animView.dart';

class ListItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListItemViewState();
  }
}

class _ListItemViewState extends State<ListItemView>
    with SingleTickerProviderStateMixin {
  // 父组件 点击状态 0 正常 1按压
  int _pointerState = 0;

  // 子组件 点击状态 0 正常 1按压
  int _childrenPointerState = 0;

  ///创建评价按钮
  Widget _buildCommentButton() {
    return AnimViewFactory.createView(
      key: "list",
      tightW: 50,
      tightH: 20,
      state: this,
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            _childrenPointerState = 1;
          });
        },
        onPointerUp: (PointerUpEvent event) {
          print("click");
          setState(() {
            _childrenPointerState = 0;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:
                  _childrenPointerState == 1 ? Colors.grey[100] : Colors.white,
              border: Border.all(color: Color(0xFF00C3AA), width: 1.0),
              borderRadius: BorderRadius.circular(13.0)),
          child: Text(
            "评价",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Color(0xFF00C3AA)),
          ),
        ),
      ),
    );
  }

  ///构建视图上部分
  Widget _buildHeader() {
    return SizedBox(
      height: 38.0,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 16,
            child: AnimViewFactory.createView(
              key: "list",
              tightW: 28,
              tightH: 20,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 38.0,
                child: Text(
                  "私教",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF4A4A4A)),
                ),
              ),
              state: this,
            ),
          ),
          Positioned(
            right: 16.0,
            child: AnimViewFactory.createView(
              key: "list",
              tightW: 42,
              tightH: 20,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 38.0,
                child: Text(
                  "待上课",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF4A4A4A)),
                ),
              ),
              state: this,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建内容视图
  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 14.0, 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 3.0),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(3.0)),
            child: AnimViewFactory.createView(
              key: "list",
              tightW: 75,
              tightH: 75,
              child: Image.network(
                "",
                width: 75.0,
                height: 75.0,
                fit: BoxFit.cover,
              ),
              state: this,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  AnimViewFactory.createView(
                    key: "list",
                    tightW: 64,
                    tightH: 22,
                    child: Text(
                      "力量训练",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF262628),
                      ),
                    ),
                    state: this,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    height: 20.0,
                    child: AnimViewFactory.createView(
                      key: "list",
                      tightW: 64,
                      tightH: 20,
                      child: Text(
                        "梁德勋",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF9B9B9B),
                        ),
                      ),
                      state: this,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: AnimViewFactory.createView(
                      key: "list",
                      tightW: 174,
                      tightH: 20,
                      child: Text(
                        "2018-02-23  20:00-20:20",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF9B9B9B),
                        ),
                      ),
                      state: this,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建分割线
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Color(0xFFF5F5F5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          print('up');
          if (_childrenPointerState == 0) {
            _pointerState = 1;
          }
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          print('up 2');
          if (_childrenPointerState == 0) {
            _pointerState = 0;
          }
        });
      },
      child: Container(
        color: _pointerState == 1 ? Colors.grey[100] : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildHeader(),
            _buildDivider(),
            _buildContent(),
            _buildDivider(),
            SizedBox(
              height: 41.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 16.0,
                    child: AnimViewFactory.createView(
                      key: "list",
                      tightW: 174,
                      tightH: 20,
                      child: new Text(
                        "深圳海岸城-体能馆·4排8座",
                        style:
                            TextStyle(color: Color(0xFF4A4A4A), fontSize: 14.0),
                      ),
                      state: this,
                    ),
                  ),
                  Positioned(
                      right: 16.0,
                      child: false
                          ? new Text(
                              "一天后开始",
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF00C3AA)),
                            )
                          : _buildCommentButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
