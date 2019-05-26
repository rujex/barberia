import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/root_page.dart';
import 'package:flutter_login_demo/services/authentication.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Barbería app',
        theme: new ThemeData(
          brightness: Brightness.dark,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
