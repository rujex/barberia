import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
*
* Clase que muestra las citas del cliente y también las puede cancelar
*/
class Misreservas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Reservasui();
}

class Reservasui extends State<Misreservas> {
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

  // consulta a firebase para eliminar la reserva que por parametro se le pasa el id del documento
  eliminarReserva(doc) {
    Firestore.instance
        .collection(Constants.reservesCollectionId)
        .document(doc)
        .delete();
  }
  // Muestra un dialogo que si el usuario pulsa en si elimina la reserva 
  // le paso por parametro el id del documento para que se lo pase al método
  // eliminar reserva
  void mostrarDialogo(doc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atención'),
            content: Text('¿Estas seguro de cancelar la reserva?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Si'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  eliminarReserva(doc);
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
 // Construye el interfaz mostrando todas las citas del usuario conectado
  @override
  Widget build(BuildContext context) {

    // se almacena el email del usuario conectado
    String email = "${user?.email}";

    DateTime fecha = DateTime.now();
    String fechaa = DateFormat("MM/dd/yyy").format(fecha).toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Citas'),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('reservas')
                  .where('usuario', isEqualTo: email)
                  .where('fecha', isGreaterThan: fechaa)
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
                              Container(
                                  child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(children: <Widget>[
                                  Text(
                                    document['fecha'] + '      ',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    document['hora'] +
                                        '                               ',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  IconButton(
                                    alignment: Alignment.centerRight,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      mostrarDialogo(document.documentID);
                                    },
                                  )
                                ]),
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
