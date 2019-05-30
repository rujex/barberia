import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/cesta.dart';

/*
* 
* Muestra todos los productos almacenados en la base de datos además
* el cliente puede comprar los productos para recoger en el establecimiento
*/

class Productos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Interfaz();
}

class Interfaz extends State<Productos> {
  // Construye la interfaz de la cabecera que muestra el backbutton
  // y un iconbutton de la cesta
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Productos'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Cesta'),
              ),
              IconButton(
                  iconSize: 35.0,
                  color: Colors.blue,
                  icon: new Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Cesta()));
                  })
            ],
          ),
          body: MyStatelessWidget(),
        ),
        theme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
  // metodo que almacena en la base de datos la compra (usuario y producto) realizada por el usuario
  // se le pasa por parametro el nombre del producto
  guardarCompra(producto) async {
    String userEmail;

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;

    var data = {'usuario': userEmail, 'producto': producto};

    Firestore.instance.collection('compras').add(data);
  }
  // notifica al usuario que la compra ha sido realizada con éxito
  void notificacion(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('La compra ha sido realizada con éxito'),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  // muestra un dialogo, si pulsa 'si' llama a los métodos guardarCompra y notificación
  // se le pasa por parametro el contexto y el producto
  void mostrarDialogo(context, producto) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atención'),
            content: Text('¿Estas seguro de comprar el producto?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Si'),
                onPressed: () {
                  guardarCompra(producto);
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Cesta()));
                  notificacion(context);
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
 // Clase que construye la interfaz mostrando los productos
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(Constants.productosCollectionId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return Container(
                        child: ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              ClipOval(
                                child: Image.network(
                                  document['imagen'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                  width: 210,
                                  child: Padding(
                                    padding: EdgeInsets.all(50.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          document['nombre'],
                                          style: TextStyle(
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 3),
                                        ),
                                        Text(
                                          document['descripcion'],
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 3),
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            document['precio'] +
                                                '€' +
                                                ' Comprar',
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            Interfaz().mostrarDialogo(
                                                context, document['nombre']);
                                          },
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        );
                      }).toList(),
                    ));
                }
              },
            )),
      ),
    );
  }
}
