import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:provider/provider.dart';

const String LoggedInKey = 'LoggedIn';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  bool _initialized = false;
  late AppState appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Icon(Icons.wb_cloudy_outlined)
          ),
        ),
      ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 2000), () {
        appState.setSplashFinished();
      });
    }
  }
}