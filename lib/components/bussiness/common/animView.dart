import 'package:flutter/material.dart';
import 'dart:async';

class InitAnimView extends StatefulWidget {
  InitAnimView({Key key, @required this.child}) : super(key: key);

  final Widget child;

  //动画状态 0停止 1循环
  int animState = 1;

  Function() _start;
  Function() _stop;

  @override
  State<StatefulWidget> createState() {
    return _InitAnimViewState();
  }

  void stop() {
    _stop();
  }

  void start() {
    _start();
  }
}

class _InitAnimViewState extends State<InitAnimView>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    widget._start = () {
      if (controller.isDismissed) controller.forward();
      setState(() {
        widget.animState = 1;
      });
    };

    widget._stop = () {
      if (controller.isAnimating) controller.stop();
      setState(() {
        widget.animState = 0;
      });
    };

    controller = new AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    animation = new Tween<double>(begin: 0.0, end: 3.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear))
          ..addListener(() {
            setState(() => {});
          });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.animState == 1) {
          // 循环执行
          wait();
        }
      }
    });

    controller.forward();
  }

  Future<Null> wait() async {
    await Future.delayed(Duration(seconds: 1), () {
      controller.reset();
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[200], Colors.grey[300], Colors.grey[200]],
              begin: Alignment(-1, 0.0),
              end: Alignment(animation.value, 0.0),
            ),
          ),
          child: widget.child),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AnimViewFactory {
  static Map<Object, AnimConfig> _amap = Map();

  static Widget createView(
      {Object key,
      double tightW,
      double tightH,
      Widget child,
      SingleTickerProviderStateMixin state}) {
//  static Widget createView(
//      key, tightW, tightH, child, SingleTickerProviderStateMixin state) {
    if (tightW == null ||
        tightH == null ||
        key == null ||
        child == null ||
        state == null) return null;

    if (_amap[key] == null) {
      var vrags = _getAnimation(state);
      _amap[key] = new AnimConfig(
          animState: 0, controller: vrags[1], animation: vrags[0]);
    }

    return new Container(
      child: new AnimatedBuilder(
          animation: _amap[key].animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                decoration: _amap[key].animState == 1
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[200],
                            Colors.grey[300],
                            Colors.grey[200],
                          ],
                          begin: Alignment(-1, 0.0),
                          end: Alignment(_amap[key].animation.value, 0.0),
                        ),
                      )
                    : null,
                constraints: _amap[key].animState == 1
                    ? BoxConstraints.tightFor(width: tightW, height: tightH)
                    : null,
                child: _amap[key].animState == 1 ? null : child);
          },
          child: child),
    );
  }

  static List _getAnimation(SingleTickerProviderStateMixin state) {
    var _controller = new AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: state);

    var _animation = new Tween<double>(begin: 0.0, end: 3.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("completed");
        // 循环执行
        _wait(_animation, _controller);
      }
      if (status == AnimationStatus.dismissed) {
        print("dismissed");
      }
      if (status == AnimationStatus.forward) {
        print("forward");
      }
      if (status == AnimationStatus.reverse) {
        print("reverse");
      }
    });

    return [_animation, _controller];
  }

  static Future<Null> _wait(_animation, _controller) async {
    await Future.delayed(Duration(seconds: 1), () {
      if (_animation.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  static start(Object key) {
    var config = _amap[key];
    if (key == null || config == null) return;
    config.animState = 1;
    if (config.controller.isDismissed) config.controller.forward();
  }

  static stop(Object key) {
    var config = _amap[key];
    if (key == null || config == null) return;
    config.animState = 0;
    config.controller.reset();
  }

  static dispose(Object key) {
    var config = _amap[key];
    if (key == null || config == null) return;
    config.controller.dispose();
    config = null;
    _amap.remove(key);
  }
}

class AnimConfig {
  AnimConfig(
      {@required this.animState,
      @required this.controller,
      @required this.animation});

  Animation<double> animation;
  AnimationController controller;
  int animState; // 0停止 1播放
}
