import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barberia/paginas/registro.dart';
import 'rutas.dart';
import 'theme.dart';

void main() => runApp(Barberia());

class Barberia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BarberiaState();
}

class _BarberiaState extends State<Barberia> {
  Widget rootPage = RegistroPage();

  Future<Widget> getRootPage() async =>
      await FirebaseAuth.instance.currentUser() == null
          ? RegistroPage()
          : Barberia();

  @override
  initState() {
    super.initState();
    getRootPage().then((Widget page) {
      setState(() {
        rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barberia App',
      theme: buildAppTheme(),
      home: rootPage,
      routes: buildAppRoutes(),
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
            Text('Reservar'),
            IconButton(
              icon: Icon(Icons.add_box),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/reservar');
              },
            ),
            Text('Productos'),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              iconSize: 70,
              onPressed: () {
                print("has pulsado");
              },
            ),
            Text('Horario'),
            IconButton(
              icon: Icon(Icons.calendar_today),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/horario');
              },
            ),
            Text('Localización'),
            IconButton(
              icon: Icon(Icons.location_on),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/localizacion');
              },
            ),
          ],
        ),
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
              title: Text('Reservar'),
              onTap: () {
                Navigator.pushNamed(context, '/reservar');
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
