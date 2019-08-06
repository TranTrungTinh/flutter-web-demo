import 'package:flutter_web/material.dart';

import 'package:movie_web/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  String title = "Flutter Cinema";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$title',
      home: HomePage(title: "$title"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Orbitron',
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        backgroundColor: Colors.grey[100],
      ),
      // routes: {
      //   '/': (context) => HomePage(title: "$title"),
      //   '/movie': (context) => DetailPage(),
      //   '/about': (context) => AboutPage()
      // },
      // onGenerateRoute: _getRoute
    );
  }
}

// Route<dynamic> _getRoute(RouteSettings settings) {
//     if (settings.name == '/movie') {
//         // FooRoute constructor expects SomeObject
//         return _buildRoute(settings, DetailPage());
//     }

//     return null;
// }

// MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
//     return MaterialPageRoute(
//         settings: settings,
//         builder: (ctx) => builder
//     );
// }