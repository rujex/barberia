import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barberia/modelo/reservasModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservar extends StatefulWidget {
  @override
  _ReservarState createState() => _ReservarState();
}

class _ReservarState extends State<Reservar> {

  TextEditingController _nombreApellido;
  TextEditingController _dni;
  TextEditingController _fecha;
  TextEditingController _domicilio;
  TextEditingController _movil;
  TextEditingController _arreglo;

  @override
  void initState() {
    super.initState();
    _nombreApellido = TextEditingController();
    _dni = TextEditingController();
    _fecha = TextEditingController();
    _domicilio = TextEditingController();
    _movil = TextEditingController();
    _arreglo = TextEditingController();
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Firestore _database = new Firestore();

  // Controladores de texto


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Reservar'),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nombreApellido,
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.person),
                        hintText: 'Escribe tu nombre y apellidos',
                        labelText: 'Nombre y apellidos'
                    ),
                  ),
                  TextFormField(
                    controller: _dni,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.assignment),
                      hintText: 'Escribe tu dni',
                      labelText: 'DNI',
                    ),
                  ),
                  TextFormField(
                    controller: _fecha,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Indica la fecha',
                      labelText: 'Fecha',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  new TextFormField(
                    controller: _domicilio,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: 'Escribe tu domicilio',
                      labelText: 'Domicilio',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    controller: _movil,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Escribe tu número de móvil',
                      labelText: 'Móvil',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                  ),
                  TextFormField(
                    controller: _arreglo,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.content_cut),
                      hintText: 'Escribe el tipo de arreglo',
                      labelText: 'Tipo de Corte de pelo o arreglo de barba',
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Enviar'),
                        onPressed: _submitForm(_nombreApellido.text.toString(), _dni.text.toString(), _fecha.text.toString(), _domicilio.text.toString(), _movil.text.toString(), _arreglo.text.toString()),
                      )),
                ],
              ))),
    );
  }


  void showMessage(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: Text(message)));
  }

  _submitForm(String nombre, String dni, String fecha, String domicilio, String movil, String arreglo  ) {
      if (nombre.length > 0 && dni.length > 0  && fecha.length > 0 && domicilio.length > 0 && movil.length > 0 && arreglo.length > 0) {
        Reservas reservas = new Reservas(nombre.toString(), dni.toString(), fecha.toString(), domicilio.toString(), movil.toString(), arreglo.toString());
        _database.collection("reservas").add(reservas.toJson());
      }
  }
}
