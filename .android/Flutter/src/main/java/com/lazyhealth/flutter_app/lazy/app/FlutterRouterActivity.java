package com.lazyhealth.flutter_app.lazy.app;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.lazyhealth.flutter_app.lazy.FlutterLayer;
import com.lazyhealth.flutter_app.lazy.statics.Channels;
import com.lazyhealth.flutter_app.lazy.utils.JsonUtils;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public final class FlutterRouterActivity extends FlutterActivity {

    private MethodChannel channel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        initFlutterNativeMethod();
    }

    /**
     * 注册flutter调用原生回调
     */
    private void initFlutterNativeMethod() {
        channel = new MethodChannel(getFlutterView(), Channels.BASE);
        channel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "nativePop":
                    nativePop(result);
                    break;
                case "nativePopResult":
                    nativePopResult(call.arguments, result);
                    break;
                case "nativeStart":
                    nativeStart(call.arguments, result);
                    break;
                default:
                    result.notImplemented();
                    break;
            }
        });
    }

    /**
     * Native当前页出栈,无参数
     *
     * @param result flutter MethodChannel回调
     */
    private void nativePop(MethodChannel.Result result) {
        finish();
        result.success(null);
    }

    /**
     * Native当前页出栈,返回参数至上一个Activity
     *
     * @param arguments flutter返回参数对象
     * @param result    flutter MethodChannel回调
     */
    private void nativePopResult(Object arguments, MethodChannel.Result result) {
        JSONObject jsonArguments;
        try {
            HashMap<String, Object> map = (HashMap<String, Object>) arguments;
            jsonArguments = new JSONObject(map);
        } catch (Exception e) {
            result.error("arguments no map", null, null);
            return;
        }

        int requestCode = getIntent().getIntExtra("requestCode", 0x89898989);
        if (requestCode == 0x89898989) throw new RuntimeException("requestCode is null");

        HashMap<String, Object> params = new HashMap<>();
        params.put("requestCode", requestCode);
        params.put("success", true);
        params.put("arguments", jsonArguments.toString());

        if (FlutterLayer.flutterResultCallbacks.containsKey(requestCode)) {
            FlutterLayer.flutterResultCallbacks.remove(requestCode)
                    .flutterResult(requestCode, params);
            finish();
        } else {
            throw new RuntimeException("callback is null");
        }

        result.success(null);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        flutterFinishResult(requestCode, resultCode, data);
    }

    /**
     * flutter 调用 原生页面入栈
     *
     * @param arguments flutter 入参
     * @param result
     */
    private void nativeStart(Object arguments, MethodChannel.Result result) {
        Map<String, Object> params;
        try {
            params = (HashMap<String, Object>) arguments;
        } catch (Exception e) {
            result.error("arguments no map", null, null);
            return;
        }
        String url = (String) params.get("url");
        Map<String, Object> args = null;
        if (params.containsKey("arguments")) {
            args = (Map<String, Object>) params.get("arguments");
        }
        if (params.containsKey("requestCode")) {
            FlutterLayer.iPlatform.startActivityResult(this, url, (int) params.get("requestCode"), args);
        } else {
            FlutterLayer.iPlatform.startActivity(this, url, args);
        }
    }

    /**
     * flutter调用原生后，原生页面出栈后返回参数传递
     */
    private void flutterFinishResult(int requestCode, int resultCode, Intent data) {

        HashMap<String, Object> params = new HashMap<>();
        params.put("requestCode", requestCode);
        params.put("success", resultCode == RESULT_OK);

        try {
            Map<String, Object> arguments = JsonUtils.getMap(data.getStringExtra("arguments"));
            params.put("arguments", arguments);
        } catch (Exception e) {
            Log.d("jean", e.getMessage());
        }

        postFlutterMethod("finishResult", params, new MethodChannel.Result() {
            @Override
            public void success(@Nullable Object o) {
                Log.d("flutter", "UI startFlutter arguments success");
            }

            @Override
            public void error(String s, @Nullable String s1, @Nullable Object o) {
                Log.e("flutter", "UI startFlutter arguments error , error is " + s);
            }

            @Override
            public void notImplemented() {
                Log.d("flutter", "UI startFlutter noImplemented ");
            }
        });
    }

    /**
     * native 调用 flutter 方法，不带回调
     *
     * @param method flutter 方法名
     * @param params function 参数
     */
    protected void postFlutterMethod(String method, Object params) {
        channel.invokeMethod(method, params);
    }

    /**
     * native 调用 flutter 方法，带回调
     *
     * @param method flutter 方法名
     * @param params function 参数
     * @param result flutter MethodChannel回调
     */
    protected void postFlutterMethod(String method, Object params, MethodChannel.Result result) {
        channel.invokeMethod(method, params, result);
    }
}
