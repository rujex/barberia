import 'package:flutter/material.dart';
import 'login.dart';
import 'registro.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => new LoginPage(),
    '/registro': (BuildContext context) => new RegistroPage(),
  };
}