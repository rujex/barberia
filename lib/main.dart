import 'package:flutter/material.dart';
import 'horario.dart';
import 'localizacion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barberia App',
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => Inicio(),
        '/horario': (context) => Horario(),
        '/localizacion': (context) => Localizacion(),
      },
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
                  icon: Icon(Icons.add_box) ,
                  iconSize: 70,
                  onPressed: () { print("sadsa"); },
              ),
              Text('Productos'),
              IconButton(
                icon: Icon(Icons.add_shopping_cart) ,
                iconSize: 70,
                onPressed: () { print("has pulsado"); },
              ),
              Text('Horario'),
              IconButton(
                icon: Icon(Icons.calendar_today) ,
                iconSize: 70,
                onPressed: () {
                  Navigator.pushNamed(context, '/horario');
                },
              ),
              Text('Localización'),
              IconButton(
                icon: Icon(Icons.location_on) ,
                iconSize: 70,
                onPressed: () {
                  Navigator.pushNamed(context, '/localizacion');
                },
              ),
            ],
          ) ,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Rubén'),
                accountEmail: Text('rujex93rujex@gmail.com'),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('http://i.pravatar.cc/300'),
                ),
              ),
              ListTile(
                title: Text('Reservas'),
                onTap: () {
                  Navigator.pushNamed(context, '/reservas');
                },
              ),
              Divider(
                color: Colors.black,
                height: 5.0,
              ),
              ListTile(
                title: Text('Productos'),
                onTap: () {
                  Navigator.pushNamed(context, '/productos');
                },
              ),
              Divider(
                color: Colors.black,
                height: 5.0,
              ),
              ListTile(
                title: Text('Horario'),
                onTap: () {
                  Navigator.pushNamed(context, '/horario');
                },
              ),
              Divider(
                color: Colors.black,
                height: 5.0,
              ),
              ListTile(
                title: Text('Localización'),
                onTap: () {
                  Navigator.pushNamed(context, '/localizacion');
                },
              ),
            ],
          ),
        ),
      );
    }
  }
  