import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barberia/paginas/registro.dart';
import 'rutas.dart';
import 'theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations.dart';

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
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('es', ''),
          const Locale('en', ''),
      ],
      home: rootPage,
      routes: buildAppRoutes(),
    );
  }
}

class Inicio extends StatelessWidget {

  //información del usuario logueado

  var user = FirebaseAuth.instance.currentUser;
  var nombre = user.displayName;
  var email = user.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('app_title')),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Translations.of(context).text('reserve')),
            IconButton(
              icon: Icon(Icons.add_box),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/reservar');
              },
            ),
            Text(Translations.of(context).text('products')),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              iconSize: 70,
              onPressed: () {
                print("has pulsado");
              },
            ),
            Text(Translations.of(context).text('haircut')),
            IconButton(
              icon: Icon(Icons.content_cut),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/cortes');
              },
            ),
            Text(Translations.of(context).text('schedule')),
            IconButton(
              icon: Icon(Icons.calendar_today),
              iconSize: 70,
              onPressed: () {
                Navigator.pushNamed(context, '/horario');
              },
            ),
            Text(Translations.of(context).text('location')),
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
              accountName: Text(nombre),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            ListTile(
              title: Text(Translations.of(context).text('reserve')),
              onTap: () {
                Navigator.pushNamed(context, '/reservar');
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text(Translations.of(context).text('products')),
              onTap: () {
                Navigator.pushNamed(context, '/productos');
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text(Translations.of(context).text('schedule')),
              onTap: () {
                Navigator.pushNamed(context, '/horario');
              },
            ),
            ListTile(
              title: Text(Translations.of(context).text('haircut')),
              onTap: () {
                Navigator.pushNamed(context, '/cortes');
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text(Translations.of(context).text('location')),
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
