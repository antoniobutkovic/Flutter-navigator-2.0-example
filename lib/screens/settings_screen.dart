import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(onPressed: () {
            appState.logout();
          },
          child: Text('Logout'),)
        ),
      ),
    );
  }
}
