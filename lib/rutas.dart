import 'package:flutter/material.dart';
import 'package:barberia/paginas/login.dart';
import 'package:barberia/paginas/registro.dart';
import 'package:barberia/main.dart';
import 'package:barberia/paginas/reservar.dart';
import 'package:barberia/paginas/horario.dart';
import 'package:barberia/paginas/localizacion.dart';
import 'package:barberia/modelo/reservas.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => new LoginPage(),
    '/registro': (BuildContext context) => new RegistroPage(),
    '/main': (BuildContext context) => new Inicio(),
    '/reservar': (BuildContext context) => new Reservar(),
    '/horario': (BuildContext context) => new Horario(),
    '/localizacion': (BuildContext context) => new Localizacion(),

  };
}