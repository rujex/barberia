// Flutter code sample for material.Card.1

// This sample shows creation of a [Card] widget that shows album information
// and two actions.

import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


/// This Widget is the main application widget.
class Cortes extends StatelessWidget {
  static const String _title = 'Cortes de pelo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),),
          ),
        body: MyStatelessWidget(),
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
      )
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(Constants.cortesCollectionId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Dialog(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Cargando"),
                  ],
                ),
              ),
            );
          default:
            return ListView(
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
                          width: 250,
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
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                        )
                        )
                      ],
                    ),
                  );
              }).toList(),
            );
        }
      },
    );
  }
}