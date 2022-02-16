import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator_2/app_state.dart';
import 'package:flutter_navigator_2/navigator/back_dispatcher.dart';
import 'package:flutter_navigator_2/navigator/page_configuration.dart';
import 'package:flutter_navigator_2/screens/login_screen.dart';
import 'package:flutter_navigator_2/screens/main_screen.dart';
import 'package:flutter_navigator_2/screens/register_screen.dart';
import 'package:flutter_navigator_2/screens/settings_screen.dart';
import 'package:flutter_navigator_2/screens/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<Page> _pages = [];
  MyBackButtonDispatcher? backButtonDispatcher;

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppState appState;

  MyRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void addPage(PageConfiguration? pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig?.uiPage;
    if (shouldAddPage) {
      switch (pageConfig?.uiPage) {
        case Pages.Splash:
          _addPageData(SplashScreen(), SplashPageConfig);
          break;
        case Pages.Login:
          _addPageData(LoginScreen(), LoginPageConfig);
          break;
        case Pages.Register:
          _addPageData(RegisterScreen(), RegisterPageConfig);
          break;
        case Pages.Main:
          _addPageData(MainScreen(), MainPageConfig);
          break;
        case Pages.Settings:
          _addPageData(SettingsScreen(), SettingsPageConfig);
          break;
        default:
          break;
      }
    }
  }

  void replace(PageConfiguration? newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void _setPageAction(PageAction action) {
    switch (action.page?.uiPage) {
      case Pages.Splash:
        SplashPageConfig.currentPageAction = action;
        break;
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.Register:
        RegisterPageConfig.currentPageAction = action;
        break;
      case Pages.Main:
        MainPageConfig.currentPageAction = action;
        break;
      case Pages.Settings:
        SettingsPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  List<Page> buildPages() {
    if (!appState.splashFinished) {
      replaceAll(SplashPageConfig);
    } else {
      switch (appState.currentAction.state) {
        case PageState.none:
          break;
        case PageState.addPage:
          _setPageAction(appState.currentAction);
          addPage(appState.currentAction.page);
          break;
        case PageState.pop:
          pop();
          break;
        case PageState.replace:
          _setPageAction(appState.currentAction);
          replace(appState.currentAction.page);
          break;
        case PageState.replaceAll:
          _setPageAction(appState.currentAction);
          replaceAll(appState.currentAction.page!);
          break;
        case PageState.addAll:
          addAll(appState.currentAction.pages!);
          break;
      }
    }
    appState.resetCurrentAction();
    return List.of(_pages);
  }
}