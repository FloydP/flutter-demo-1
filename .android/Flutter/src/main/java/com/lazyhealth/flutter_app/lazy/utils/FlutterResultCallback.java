package com.lazyhealth.flutter_app.lazy.utils;

import java.util.Map;

public interface FlutterResultCallback {
    void flutterResult(int requestCode, Map<String, Object> result);
}
