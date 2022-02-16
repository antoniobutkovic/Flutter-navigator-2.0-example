import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/navigator/page_configuration.dart';

class MyRouteInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SplashPageConfig;
    }

    final path = '/' + uri.pathSegments[0];
    switch (path) {
      case SplashPath:
        return SplashPageConfig;
      case LoginPath:
        return LoginPageConfig;
      case RegisterPath:
        return RegisterPageConfig;
      case MainScreenPath:
        return MainPageConfig;
      case SettingsPath:
        return SettingsPageConfig;
      default:
        return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);
      case Pages.Login:
        return const RouteInformation(location: LoginPath);
      case Pages.Register:
        return const RouteInformation(location: RegisterPath);
      case Pages.Main:
        return const RouteInformation(location: MainScreenPath);
      case Pages.Settings:
        return const RouteInformation(location: SettingsPath);
      default: return const RouteInformation(location: SplashPath);

    }
  }
}