import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mostrarReservas extends StatefulWidget {
  @override
  _mostrarReservasState createState() => _mostrarReservasState();
}

final reservasReference = FirebaseAuth.instance.reference().child('reservas');

class _mostrarReservasState extends State<mostrarReservas> {

  List<Reservas> items;
  StreamSubscription<Event> _agregarReservas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _agregarReservas = reservasReference.onChildAdded.listen(_agregarReservas);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _agregarReservas.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reservas'),
        ),
      ),
    );
  }
}
