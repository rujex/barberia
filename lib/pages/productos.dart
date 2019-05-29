// Flutter code sample for material.Card.1

// This sample shows creation of a [Card] widget that shows album information
// and two actions.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/cesta.dart';
import 'package:flutter_login_demo/pages/home_page.dart';
import 'package:flutter_login_demo/pages/misreservas.dart';

/// This Widget is the main application widget.

class Productos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Interfaz();
}

class Interfaz extends State<Productos> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Productos'),
          leading: IconButton(icon: Icon(Icons.arrow_back), 
          onPressed: () => Navigator.pop(context, false),),
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
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                       new Cesta()
                      ));
              }
            )
          ],
        ),
        body: MyStatelessWidget(),
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
      )
    );
  }

// StateModel appState;
// final email = appState?.firebaseUserAuth?.email ?? '';
// var user = FirebaseAuth.instance.currentUser();
// var email = user.email;



 guardarCompra(producto) async {

   String userEmail;

   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   userEmail = user.email;


     var data = {
        'usuario': userEmail,
        'producto': producto
    };


    Firestore.instance.collection('compras').add(data);


    // final CollectionReference reference = Firestore.instance.collection('compras');
    // Firestore.instance.runTransaction((Transaction transaction) async {
    //   await reference.add({
    //     "usuario": getEmail(),
    //     "producto": producto
    //   });
    // }
    // );
    }

//  void notificacion(context){
//    SnackBar(
//      content: Text('holaaa'),
//    )
//  }


 void mostrarDialogo(context, producto){
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

                 Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                       new Cesta()
                      ));
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
       }
     );
  }


}

/// This is the stateless widget that the main application instantiates.
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
                      //  return CircularProgressIndicator();
                  case ConnectionState.done:
                        return Container(
                    child: ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        ClipOval (
                            child: Image.network(
                            document['imagen'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            ),
                        ),
                        Container(
                          width: 200,
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
                              Text(
                                  document['descripcion'],
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                RaisedButton(
                                  child: Text(document['precio'] + '€' + ' Comprar'),
                                  onPressed: (){
                                    Interfaz().mostrarDialogo(context, document['nombre']);
                                  },
                                )
                              ],
                            ),
                        )
                        )
                      ],
                    ),
                  );
              }).toList(),
                    )
            );
                  
                }
              },
            )),
      ),

    );
  }
}
