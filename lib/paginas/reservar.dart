import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barberia/modelo/reservasModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservar extends StatefulWidget {
  @override
  _ReservarState createState() => _ReservarState();
}

class _ReservarState extends State<Reservar> {

  // Almaceno la información introducida en los input

  TextEditingController _nombreApellido;
  TextEditingController _dni;
  TextEditingController _fecha;
  TextEditingController _domicilio;
  TextEditingController _movil;
  TextEditingController _arreglo;

  // Referencias a firebase, formulario y diseño

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Firestore _database = new Firestore();


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
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe tu nombre y apellidos';
                      }
                    },
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.person),
                        hintText: 'Escribe tu nombre y apellidos',
                        labelText: 'Nombre y apellidos'
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    controller: _dni,
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe el dni';
                      }
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.assignment),
                      hintText: 'Escribe tu dni',
                      labelText: 'DNI',
                    ),
                    maxLength: 9,
                    inputFormatters: WhitelistingTextInputFormatter(RegExp("^(([A-Z]\d{8})|(\d{8}[A-Z]))$")),

                  ),
                  TextFormField(
                    controller: _fecha,
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe la fecha';
                      }
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Indica la fecha',
                      labelText: 'Fecha',
                    ),
                    keyboardType: TextInputType.datetime,
                    initialDate: Timestamp.now()
                  ),
                  new TextFormField(
                    controller: _domicilio,
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe el domicilio';
                      }
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: 'Escribe tu domicilio',
                      labelText: 'Domicilio',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    controller: _movil,
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe tu numero de móvil';
                      }
                    },
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
                    validator: (value) {
                      if (value.isEmpty) {
                          return 'Escribe el corte de pelo';
                      }
                    },
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
                        onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold
                                  .of(context)
                                  .showSnackBar(Snackbar(content: Text('Guardando datos')));
                            }
                        _submitForm(_nombreApellido.text.toString(), _dni.text.toString(), _fecha.text.toString(), _domicilio.text.toString(), _movil.text.toString(), _arreglo.text.toString()),
                        }
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
