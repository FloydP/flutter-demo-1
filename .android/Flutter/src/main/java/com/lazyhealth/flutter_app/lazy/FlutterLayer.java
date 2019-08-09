package com.lazyhealth.flutter_app.lazy;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.util.Log;

import com.lazyhealth.flutter_app.lazy.app.FlutterRouterActivity;
import com.lazyhealth.flutter_app.lazy.model.FlutterArguments;
import com.lazyhealth.flutter_app.lazy.utils.FlutterResultCallback;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import io.flutter.facade.Flutter;

import static android.app.Activity.RESULT_OK;

/**
 * FlutterUI 代理者
 */
public class FlutterLayer {

    private static final String ROUTE_ACTION = "android.intent.action.RUN";

    public static IPlatform iPlatform;

    public static HashMap<Integer, FlutterResultCallback> flutterResultCallbacks = new LinkedHashMap<>();

    public static void init(IPlatform iPlatform) {
        FlutterLayer.iPlatform = iPlatform;
        Flutter.startInitialization(iPlatform.getApplication());
    }

    /**
     * startFlutter flutter 页面，无页面返回参数
     *
     * @param context   Android Context
     * @param ui        要跳转到的 Flutter页面
     * @param arguments 页面传递参数
     */
    public static void startFlutter(@NonNull Context context,
                                    @NonNull FlutterUI ui,
                                    FlutterArguments arguments) {

        String routerUrl = getRouterUrl(ui);

        if (routerUrl == null || routerUrl.isEmpty()) {
            Log.d("flutter", "routerUrl is null");
        } else {    
            Map<String, Object> map = new HashMap<>();
            map.put("route", routerUrl);
            map.put("arguments", arguments.getMap());
            Intent intent = new Intent(context, FlutterRouterActivity.class);
            intent.putExtra("route", new JSONObject(map).toString());
            intent.setAction(ROUTE_ACTION);
            intent.addCategory(Intent.CATEGORY_DEFAULT);
            context.startActivity(intent);
        }
    }

    /**
     * startFlutter flutter 页面，有页面返回参数
     *
     * @param context     Android Activity
     * @param requestCode 请求码
     * @param ui          要跳转到的 Flutter页面
     * @param arguments   页面传递参数
     */
    public static void startFlutterForResult(@NonNull Activity context,
                                             int requestCode,
                                             @NonNull FlutterUI ui,
                                             FlutterArguments arguments) {

        // activity 应该实现了 FlutterResultCallback 接口
        if (context instanceof FlutterResultCallback) {
            String routerUrl = getRouterUrl(ui);

            if (routerUrl == null || routerUrl.isEmpty()) {
                Log.d("flutter", "routerUrl is null");
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("route", routerUrl);
                map.put("arguments", arguments.getMap());
                Intent intent = new Intent(context, FlutterRouterActivity.class);
                intent.putExtra("route", new JSONObject(map).toString());
                intent.putExtra("requestCode", requestCode);
                intent.setAction(ROUTE_ACTION);
                intent.addCategory(Intent.CATEGORY_DEFAULT);
                context.startActivityForResult(intent, requestCode);

                flutterResultCallbacks.put(requestCode, (FlutterResultCallback) context);
            }
        } else {
            throw new ClassCastException("activity no impl FlutterResultCallback");
        }
    }

    /**
     * 返回flutter 页面 route
     *
     * @param ui Ui
     * @return flutter route
     */
    private static String getRouterUrl(FlutterUI ui) {
        switch (ui) {
            case def:
                // 默认页面
                return "/";
            case home:
                // 主页
                return "nativeTest";
            default:
                return null;
        }
    }

    /**
     * 结束当前活动返回给flutter页面结果
     *
     * @param activity 要结束的acitivity
     * @param params   要给flutter的参数
     */
    public static void popActivityForFlutterResult(Activity activity, Map<String, Object> params) {
        JSONObject jsonObject = new JSONObject(params);
        Intent intent = new Intent();
        intent.putExtra("arguments", jsonObject.toString());
        activity.setResult(RESULT_OK, intent);
        activity.finish();
    }

    /**
     * 注销flutter组件
     */
    public static void dipoesd() {
        iPlatform = null;
        flutterResultCallbacks.clear();
        flutterResultCallbacks = null;
    }
}
