package com.lazyhealth.flutter_app.lazy.model;

import java.io.Serializable;
import java.util.HashMap;

public class FlutterArguments implements Serializable {

    private HashMap<String, Object> map;

    public HashMap<String, Object> getMap() {
        return map;
    }

    public void setMap(HashMap<String, Object> map) {
        this.map = map;
    }
}
