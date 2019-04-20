import 'package:flutter/material.dart';
import 'rutas.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barberia App',
      theme: buildAppTheme(),
        home: Inicio(),
      routes: buildAppRoutes(),
    );}
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
  