import 'package:flutter_web/material.dart';

import 'package:movie_web/pages/home.dart';
import 'package:movie_web/pages/about-us.dart';
import 'package:movie_web/pages/detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => HomePage(title: args));
        }
        return MaterialPageRoute(builder: (_) => HomePage(title: 'Flutter Cinema'));
      case '/movie': {
        if (args is int) {
          return MaterialPageRoute(builder: (_) => DetailPage(id: args));
        }
        return _errorRoute();
      }
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ERORR 404')
        ),
        body: Center(
          child: Text('Page not found')
        )
      );
    });
  }
}