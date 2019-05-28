import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/barberia.dart';
import 'package:flutter_login_demo/pages/haircut.dart';
import 'package:flutter_login_demo/pages/localizacion.dart';
import 'package:flutter_login_demo/pages/login_signup_page.dart';
import 'package:flutter_login_demo/pages/productos.dart';
import 'package:flutter_login_demo/pages/reserves.dart';
import 'package:flutter_login_demo/services/auth_provider.dart';
import 'package:flutter_login_demo/services/authentication.dart';



void main() => runApp(Barberia());

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

   _signOut() async {
    await _auth.signOut();
    runApp(
      new MaterialApp(
        home: new LoginSignUpPage(),
      )

    );
  } 




  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
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
                    title: Text('Reservar' ,),
                    subtitle: Text('Reserva tu cita por el mejor precio'),
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new Reserves()
                    ));
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
                    subtitle: Text('Tenemos en venta productos de calidad para recoger en tienda'),
                    onTap: (){
                       Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                       new Productos()
                      ));
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
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                         new Cortes()
                     ));
                    } ,
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
                    subtitle: Text('Echa un vistazo a nuestro horario, teléfono y redes sociales'),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(
                   builder: (context) =>
                     new Info()
                 ));
                    },
                  )
                ],
              ),
            ),  Card(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.location_on),
                    title: Text('Localización'),
                    subtitle: Text('Nos ubicamos en Córdoba'),
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new Localizacion()
                 ));
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
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
            ),
            ListTile(
              title: Text('Reservar'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                    new Reserves()
                ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Productos'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                    new Productos()
                ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('La barbería'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                    new Info()
                ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Cortes de pelo'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                    new Cortes()
                ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: Text('Localización'),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                    new Localizacion()
                ));
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
                }
            )
          ],
        ),
      ),
    );
  }

}




      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('Reservar'),
      //       IconButton(
      //         icon: Icon(Icons.add_box),
      //         iconSize: 70,
      //         onPressed: () {
      //            Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //               new Reserves()
      //           ));
      //         },
      //       ),
      //       Text('Productos'),
      //       IconButton(
      //         icon: Icon(Icons.add_shopping_cart),
      //         iconSize: 70,
      //         onPressed: () {
      //            Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //               new Productos()
      //           ));
      //         },
      //       ),
      //       Text('Corte de pelo'),
      //       IconButton(
      //         icon: Icon(Icons.content_cut),
      //         iconSize: 70,
      //         onPressed: () {
      //           Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //               new Cortes()
      //           ));
      //         },
      //       ),
      //       Text('Horario'),
      //       IconButton(
      //         icon: Icon(Icons.calendar_today),
      //         iconSize: 70,
      //         onPressed: () {
      //           Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //               new Schedule()
      //           ));
      //         },
      //       ),
      //       Text('Localización'),
      //       IconButton(
      //         icon: Icon(Icons.location_on),
      //         iconSize: 70,
      //         onPressed: () {
      //           Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //               new Localizacion()
      //           ));
      //         },
      //       ),
      //     ],
      //   ),
      // ),

