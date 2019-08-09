import 'package:flutter/services.dart';
import 'package:flutter_app/utils/commonUtils.dart';

typedef void NativeFinishResultCallback(Map<String, dynamic> params);

/// 与原生交互的代理类
class NativeLayer {
  static const _platform = const MethodChannel('com.lazyhealth.flutter/base');

  NativeLayer._internal() {
    _initNativeCallHandler();
  }

  static NativeLayer _singleton = new NativeLayer._internal();

  factory NativeLayer() => _singleton;

  /// 跳转原生页请求缓存，用于返回当前页 返回数据后回调
  Map<int, NativeFinishResultCallback> nativeResultMap = new Map();

  /// 原生容器页出栈
  Future<Null> nativePop() async {
    await _platform.invokeMethod('nativePop', "111");
  }

  /// 原生容器页出栈,返回参数至上一个原生页
  Future<Null> nativePopResult(Map<String, dynamic> args) async {
    await _platform.invokeMethod('nativePopResult', args);
  }

  /// 跳转原生页面
  Future<Null> nativeStart(
    String url, {
    Map<String, dynamic> arguments,
    int requestCode,
    NativeFinishResultCallback callback,
  }) async {
    var params = new Map<String, dynamic>();
    params['url'] = url;
    if (requestCode != null) params['requestCode'] = requestCode;
    if (arguments != null && callback != null) {
      params['arguments'] = arguments;
      nativeResultMap[requestCode] = callback;
    }
    await _platform.invokeMethod('nativeStart', params);
  }

  /// 注册原生调用回调
  void _initNativeCallHandler() {
    _platform.setMethodCallHandler(_handler);
  }

  Future<dynamic> _handler(MethodCall methodCall) {
    if ("finishResult" == methodCall.method) {
      _nativeFinishResult(methodCall.arguments);
    }
    return Future.value(true);
  }

  /// 原生页面返回flutter 页面处理
  void _nativeFinishResult(dynamic arg) {
    Map<String, dynamic> map = new Map.from(arg); // 直接 as 强转会失败
    int requestCode = map["requestCode"];
    bool success = map["success"];
    Map<String, dynamic> args =
        map.containsKey("arguments") ? new Map.from(map["arguments"]) : null;
    if (requestCode != null && nativeResultMap.containsKey(requestCode)) {
      if (success) nativeResultMap[requestCode](args);
      nativeResultMap.remove(requestCode);
    }
  }
}

var nativeLayer = new NativeLayer();
