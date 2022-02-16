import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:flutter_navigator_2/navigator/page_configuration.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Main Screen',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => appState.currentAction =
                PageAction(state: PageState.addPage, page: SettingsPageConfig),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
