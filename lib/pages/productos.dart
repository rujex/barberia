// Flutter code sample for material.Card.1

// This sample shows creation of a [Card] widget that shows album information
// and two actions.

import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


/// This Widget is the main application widget.
class Productos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Productos')),
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
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(Constants.productosCollectionId)
              .snapshots(),
            builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          return CustomCard(
                            title: document['nombre'],
                            description: document['descripcion'],
                            description: document['precio'],
                          );
                      }).toList(),
                    );
                }
              },
            )),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}