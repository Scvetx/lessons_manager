import 'package:flutter/cupertino.dart';

import 'locator.dart';

class NavigationService {
  static Future<dynamic> pushNamed(String routeName, Object? arguments) {
    if (Locator.navigatorKey.currentState == null) return Future.value(null);
    return Locator.navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> popAndPushNamed(String routeName, Object? arguments) {
    if (Locator.navigatorKey.currentState == null) return Future.value(null);
    return Locator.navigatorKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> clearRouteAndPushNamed(
      String routeName, Object? arguments) {
    if (Locator.navigatorKey.currentState == null) return Future.value(null);
    return Locator.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, arguments: arguments, (Route<dynamic> route) => false);
  }
}
