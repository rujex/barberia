import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/barberia.dart';
import 'package:flutter_login_demo/pages/corte.dart';
import 'package:flutter_login_demo/pages/localizacion.dart';
import 'package:flutter_login_demo/pages/login_signup.dart';
import 'package:flutter_login_demo/pages/productos.dart';
import 'package:flutter_login_demo/pages/reservas.dart';

void main() => runApp(Barberia());

/*
* Ventana principal compuesto por un menu y una lista que te dirige a las diferentes ventanas
* de la aplicación
*/

class Barberia extends StatefulWidget {
  const Barberia({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => _BarberiaState();
}

class _BarberiaState extends State<Barberia> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  // Cerrar sesión
  _signOut() async {
    await _auth.signOut();
    runApp(new MaterialApp(
      home: new LoginSignUpPage(),
    ));
  }

  // muestra el menu y una lista con varios enlaces a otras ventanas
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Barbería app'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.add),
                    title: Text(
                      'Reservar',
                    ),
                    subtitle: Text('Reserva tu cita por el mejor precio'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Reserves()));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Productos'),
                    subtitle: Text(
                        'Tenemos en venta productos de calidad para recoger en tienda'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Productos()));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.content_cut),
                    title: Text('Cortes de pelo'),
                    subtitle: Text('Mira la variedad de cortes de pelo'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Cortes()));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.info),
                    title: Text('La barbería'),
                    subtitle: Text(
                        'Echa un vistazo a nuestro horario, teléfono y redes sociales'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Info()));
                    },
                  )
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.location_on),
                    title: Text('Localización'),
                    subtitle: Text('Nos ubicamos en Córdoba'),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Localizacion()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('http://i.pravatar.cc/300'),
              ),
              accountEmail: Text("${user?.email}"),
              accountName: null,
            ),
            ListTile(
              title: Text('Reservar'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Reserves()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Productos'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Productos()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('La barbería'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Info()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Cortes de pelo'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Cortes()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Localización'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Localizacion()));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
                title: Text('Cerrar sesión'),
                onTap: () {
                  _signOut();
                  exit(0);
                })
          ],
        ),
      ),
    );
  }
}
