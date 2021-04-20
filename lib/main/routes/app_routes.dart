import 'package:flutter/cupertino.dart';

import '../../ui/pages/feed/feed_page.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/pages/signup/signup_page.dart';
import '../../ui/pages/splash/splash_page.dart';
import '../../ui/pages/welcome/welcome_page.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const feed = '/feed';
  static const newPost = '/new-post';
  static const signup = 'signup';

  static getRoutes(_) {
    final Map<String, WidgetBuilder> routes = {
      splash: (_) => SplashPage(),
      welcome: (_) => WelcomePage(),
      signup: (_) => SignUpPage(),
      login: (_) => LoginPage(),
      feed: (_) => FeedPage(),
    };

    return routes;
  }
}
