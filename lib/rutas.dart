import 'package:flutter/material.dart';
import 'package:barberia/paginas/login.dart';
import 'package:barberia/paginas/registro.dart';
import 'package:barberia/main.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => new LoginPage(),
    '/registro': (BuildContext context) => new RegistroPage(),
    '/main': (BuildContext context) => new Inicio()
  };
}