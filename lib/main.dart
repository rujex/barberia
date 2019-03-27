import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barberia App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Inicio(),
    );
  }
}

  class Inicio extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Barbería'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Reservas'),
              IconButton(
                  icon: Icon(Icons.calendar_today) ,
                  iconSize: 70,
                  onPressed: () { print("has pulsado"); },
              ),
              Text('Productos'),
              IconButton(
                icon: Icon(Icons.add_shopping_cart) ,
                iconSize: 70,
                onPressed: () { print("has pulsado"); },
              ),
              Text('Horario'),
              IconButton(
                icon: Icon(Icons.add_shopping_cart) ,
                iconSize: 70,
                onPressed: () { print("has pulsado"); },
              ),
              Text('Contacto'),
              IconButton(
                icon: Icon(Icons.add_shopping_cart) ,
                iconSize: 70,
                onPressed: () { print("has pulsado"); },
              ),
            ],
          ) ,
        ),
        drawer: Drawer(),
      );
    }
  }
  