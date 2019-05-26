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
        appBar: AppBar(title: Text('Productos'),
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

Future<bool> infoDialog(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Estás seguro?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
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
                    return new Text('Loading...');
                  default:
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
                                  child: Text('Comprar'),
                                  onPressed: (){
                                    infoDialog(context);
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
