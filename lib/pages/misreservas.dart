// Flutter code sample for material.Card.1

// This sample shows creation of a [Card] widget that shows album information
// and two actions.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/auth_provider.dart';
import 'package:flutter_login_demo/services/authentication.dart';

/// This Widget is the main application widget.

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


  @override
  Widget build(BuildContext context) {

     String email = "${user?.email}";

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
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  document['fecha'],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  document['hora'],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ]
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
