import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/navigator/router_delegate.dart';

class MyBackButtonDispatcher extends RootBackButtonDispatcher {
  final MyRouterDelegate _routerDelegate;

  MyBackButtonDispatcher(this._routerDelegate)
      : super();

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}