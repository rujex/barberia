import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_login_demo/pages/mis_reservas.dart';

/*
* Clase que muestra la fecha y horas disponibles/ocupadas
* para que el cliente pida cita
*/
class Reserves extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Reserves> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String fecha = '';
  String horaSelect;
  String hora_actual;
  Map<String, bool> reservas = new Map();
  CollectionReference reference = Firestore.instance.collection(Constants.reservesCollectionId);
  List listaHoras = [];

  _State() {
    inicializaReservas('05/22/2019', '08:30', 12);
  }

  @override
  initState() {
    super.initState();
    consultaReservas('05/22/2019', '08:30', 12);
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  // inicializa el atributo enabled a false
  // se le pasa por parámetro la fecha, hora_inicio y num_horas
  inicializaReservas(fecha, hora_inicio, num_horas) {
    DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");

    for (var i = 0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      reservas[hora_actual] = false;
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
  }

  // Consulta en la base de datos las horas en base a la fecha seleccionada
  // se pasa por parametro: fecha, hora_inicio, num_horas
  consultaReservas(fecha, hora_inicio, num_horas) async {
    DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");
    print(fecha_actual.toIso8601String());
    String hora_actual;
    bool resultado;

    for (var i = 0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      resultado = await isHora(fecha, hora_actual);
      setState(() {
        print(hora_actual + " " + resultado.toString());
        reservas[hora_actual] = resultado;
      });
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
  }
  // Guarda la cita en la base de datos
  // le paso por parametro la fecha y hora
  guardarReserva(fecha, hora) async {
    String userEmail;

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;

    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.add({"usuario": userEmail, "fecha": fecha, "hora": hora});
    });
  }

  // metodo que muestra las horas en una lista activa o desactivada
  // según este disponible u ocupada la hora
  List<Widget> creaHoras(
      fecha, fechaSelect, horaSelect, hora_inicio, num_horas) {
    List<Widget> lista = new List();
    DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");
    var hora_actual;

    for (var i = 0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      horaSelect = hora_actual;
      listaHoras.add(horaSelect);

      lista.add(
        Card(
          child: ListTile(
            title: Text(hora_actual),
            enabled: !reservas[hora_actual],
            onTap: () {
              mostrarDialogo(
                  fecha_actual, fechaSelect, listaHoras.elementAt(i));
              print(fecha_actual);
            },
          ),
        ),
      );
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
    return lista;
  }
  // notifica al usuario que ha reservado la cita
  // se le pasa por parametro el contexto
  void notificacion(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('¡¡Bien, ya tienes cita!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  // pinta un dialogo si pulsa 'si' llama a los metodos guardarReserva
  // y notificacion. Se pasa por parametro fecha, fechaSelect y horaSelect
  void mostrarDialogo(fecha, fechaSelect, horaSelect) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atención'),
            content: Text('¿Estas seguro de reservar?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Si'),
                onPressed: () {
                  guardarReserva(fechaSelect, horaSelect);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Misreservas()));
                  notificacion(context);
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
  // Si el dato que obtiene es mayor que cero devuelve datos cuando la fecha sea igual
  // a la fecha pasada por parametro y la hora igual a la hora pasada por parametro
  Future<bool> isHora(fecha, hora) async {
    return Firestore.instance
        .collection(Constants.reservesCollectionId)
        .where("fecha", isEqualTo: fecha)
        .where("hora", isEqualTo: hora)
        .getDocuments()
        .then((reservas) {
      return reservas.documents.length > 0;
    });
  }
  // Construye el interfaz mostrando fecha seleccionada, seleccionar la fecha,
  // lista de todas las reservas y un icono que te dirige a mis citas
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Mis citas'),
          ),
          IconButton(
              iconSize: 35.0,
              color: Colors.blue,
              icon: new Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Misreservas()));
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2019, 12, 31), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    fecha = DateFormat("MM/dd/yyy").format(date).toString();
                    setState(() {
                      consultaReservas(fecha, '08:30', 12);
                      creaHoras(fecha, fecha, horaSelect, '08:30', 12);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
                },
                child: Column(
                  children: <Widget>[
                    Text(fecha),
                    Text(
                      'Selecciona la fecha',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            Expanded(
                child: ListView(
                    padding: EdgeInsets.all(8.0),
                    children: creaHoras(
                        '01/01/1990', fecha, horaSelect, '08:30', 12)))
          ],
        ),
      ),
    );
  }
}