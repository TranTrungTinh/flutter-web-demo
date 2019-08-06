import 'package:flutter_web/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text(
              'Go To Home Page',
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ),
      ),
    );
  }
}