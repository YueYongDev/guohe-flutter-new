import 'package:flutter/material.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

class AppAnalysis extends NavigatorObserver {
    @override
    void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//      if (previousRoute.settings.name != null) {
//        UmengAnalyticsPlugin.pageEnd(previousRoute.settings.name);
//      }
      if (route.settings.name != null) {
        print("umeng listen push");
        print(route.settings.name);
        UmengAnalyticsPlugin.pageStart(route.settings.name);
      }
    }

    @override
    void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
      if (previousRoute.settings.name != null) {
        UmengAnalyticsPlugin.pageStart(previousRoute.settings.name);
      }
      if (route.settings.name != null) {
        print("umeng listen pop");
        UmengAnalyticsPlugin.pageEnd(route.settings.name);
      }
    }
}