import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:flutter_navigator_2/navigator/page_configuration.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Email')),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Password')),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    appState.login();
                  },
                  child: Text('Login')
              ),
              TextButton(
                  onPressed: () {
                    appState.currentAction = PageAction(state: PageState.addPage, page: RegisterPageConfig);
                  },
                  child: Text('Register')
              )
            ],
          ),
        ),
      ),
    );
  }
}
