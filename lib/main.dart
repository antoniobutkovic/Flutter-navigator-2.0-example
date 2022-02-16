import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:flutter_navigator_2/navigator/back_dispatcher.dart';
import 'package:flutter_navigator_2/navigator/page_configuration.dart';
import 'package:flutter_navigator_2/navigator/router_delegate.dart';
import 'package:flutter_navigator_2/navigator/router_information_parser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final appState = AppState();
  final parser = MyRouteInformationParser();
  late MyRouterDelegate delegate;
  late MyBackButtonDispatcher backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    delegate = MyRouterDelegate(appState);
    delegate.setNewRoutePath(SplashPageConfig);
    backButtonDispatcher = MyBackButtonDispatcher(delegate);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        title: 'Flutter Navigator 2.0',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        backButtonDispatcher: backButtonDispatcher,
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }
}
