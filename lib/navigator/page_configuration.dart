
import 'package:flutter_navigator_2/app_state.dart';

const String SplashPath = '/splash';
const String LoginPath = '/login';
const String RegisterPath = '/register';
const String MainScreenPath = '/main';
const String SettingsPath = '/settings';

enum Pages {
  Splash,
  Login,
  Register,
  Main,
  Settings
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  PageAction? currentPageAction;

  PageConfiguration({required this.key, required this.path, required this.uiPage, this.currentPageAction});
}

PageConfiguration SplashPageConfig = PageConfiguration(key: 'splash', path: SplashPath, uiPage: Pages.Splash, currentPageAction: null);
PageConfiguration LoginPageConfig = PageConfiguration(key: 'login', path: LoginPath, uiPage: Pages.Login, currentPageAction: null);
PageConfiguration RegisterPageConfig = PageConfiguration(key: 'register', path: RegisterPath, uiPage: Pages.Register, currentPageAction: null);
PageConfiguration MainPageConfig = PageConfiguration(key: 'main', path: MainScreenPath, uiPage: Pages.Main);
PageConfiguration SettingsPageConfig = PageConfiguration(key: 'settings', path: SettingsPath, uiPage: Pages.Settings, currentPageAction: null);