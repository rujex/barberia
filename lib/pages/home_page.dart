import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(Barberia());

class Barberia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BarberiaState();
}

class _BarberiaState extends State<Barberia> {


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barberia App',
    );
  }
}

class Inicio extends StatelessWidget {

  //información del usuario logueado

  // var user = FirebaseAuth.instance.currentUser;

  final FirebaseUser user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbería app'),
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
            Text('Corte de pelo'),
            IconButton(
              icon: Icon(Icons.content_cut),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/cortes');
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
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
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
            ListTile(
              title: Text('Cortes de pelo'),
              onTap: () {
                Navigator.pushNamed(context, '/cortes');
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Location'),
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
