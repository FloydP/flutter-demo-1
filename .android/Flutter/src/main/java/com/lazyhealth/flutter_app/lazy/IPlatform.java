package com.lazyhealth.flutter_app.lazy;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.support.annotation.NonNull;

import java.util.Map;

public interface IPlatform {

    boolean isDebug();

    Application getApplication();

    void startActivity(@NonNull Context context, @NonNull String url, Map<String, Object> arguments);

    void startActivityResult(@NonNull Activity context, @NonNull String url, @NonNull int requestCode, Map<String, Object> arguments);
}
