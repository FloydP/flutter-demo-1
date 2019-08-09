package com.lazyhealth.flutter_app.lazy.model;

import java.io.Serializable;
import java.util.HashMap;

public class FlutterRouter {
    private String route;
    private HashMap<String, Object> arguments;

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public HashMap<String, Object> getArguments() {
        return arguments;
    }

    public void setArguments(HashMap<String, Object> arguments) {
        this.arguments = arguments;
    }
}
