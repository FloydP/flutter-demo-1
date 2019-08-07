import 'package:flutter/material.dart';

enum ViewState { normal, error, empty }

class RootView extends StatefulWidget {
  RootView({@required this.child, this.errorRefreshTap});

  final Widget child;

  VoidCallback errorRefreshTap;
  ViewState _viewState;
  Function() _notify;

  @override
  State<StatefulWidget> createState() {
    return _RootViewState();
  }

  void show(ViewState state) {
    this._viewState = state;
    this._notify();
  }

  void setErrorRefreshTap(VoidCallback tap) {
    this.errorRefreshTap = tap;
  }
}

class _RootViewState extends State<RootView> {
  @override
  void initState() {
    super.initState();
    widget._viewState = ViewState.normal;
    widget._notify = () {
      setState(() => {});
    };
  }

  Widget _buildView() {
    if (widget._viewState == ViewState.normal) {
      return widget.child;
    } else if (widget._viewState == ViewState.empty) {
      return _buildEmptyView();
    } else {
      return _buildError();
    }
  }

  Widget _buildEmptyView() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Text(
                "空视图",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildError() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Text(
                "网络异常，请检查网络设置",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: widget.errorRefreshTap,
                child: Text("重新加载"),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
