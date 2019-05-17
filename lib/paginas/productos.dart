// Flutter code sample for material.Card.1

// This sample shows creation of a [Card] widget that shows album information
// and two actions.

import 'package:barberia/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../translations.dart';


/// This Widget is the main application widget.
class Productos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(Translations.of(context).text('products'))),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(Constants.productosCollectionId)
          .snapshots(),
          builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return  Text('Cargando...');
                  default:
                    return Card(
                      child: snapshot.data.documents
                         .map(DocumentSnapshot document) {
                            return ListTitle(
                              leading: Icon(Icons.album),
                              title: document['nombre'],
                              subtitle: document['descripcion'],
                              subtitle: document['precio'],
                            );
                         },
                     children: <Widget>[
                  FlatButton(
                    child: const Text('Recoger en la barbería'),
                    onPressed: () {/* ... */},
                  ),
                ],
                    );
          }
    }
 }