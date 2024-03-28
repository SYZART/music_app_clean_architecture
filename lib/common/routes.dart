import 'package:flutter/material.dart';
import 'package:openmusic/presentation/pages/login_page.dart';
import 'package:openmusic/presentation/pages/main_page.dart';
import 'package:openmusic/presentation/pages/register_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';
import 'package:openmusic/presentation/pages/splash_page.dart';

class Approutes {
  static Route onGeneretaRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashPage());
      case '/home':
        return _materialRoute(const MainPage());
      case '/login':
        return _materialRoute(LoginPage());
      case '/register':
        return _materialRoute(RegisterPage());
      case '/songs':
        return _materialRoute(const SongPage());
      default:
        return _materialRoute(const SplashPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
