import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_login_demo/pages/misreservas.dart';

class Reserves extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Reserves> {
  String fecha = '';
  String horaSelect;
  Map<String,bool> reservas = new Map();
  CollectionReference reference = Firestore.instance.collection('reservas');
  List listaHoras = [];

  _State() {
    inicializaReservas('05/22/2019', '08:30', 12);
  }

  @override
  initState() {
    super.initState();
    consultaReservas('05/22/2019', '08:30', 12);
  }

  inicializaReservas(fecha, hora_inicio, num_horas) {
     DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");
    String hora_actual;

    for(var i=0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      reservas[hora_actual] = false;
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
  }

  consultaReservas(fecha, hora_inicio, num_horas) async{
   DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");
    print(fecha_actual.toIso8601String());
    String hora_actual;
    bool resultado;

    for(var i=0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      resultado = await isHora(fecha, hora_actual);
      setState(() {
        print(hora_actual+" "+resultado.toString());
        reservas[hora_actual] = resultado;
      });
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
  }

bool pintaHora(hora_actual) {
  if (fecha=='')
    return false;
  else
    return !reservas[hora_actual];
}
  
  guardarReserva(fecha, hora) async {

  String userEmail;

   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   userEmail = user.email;

   
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.add({
        "usuario": userEmail,
        "fecha": fecha,
        "hora": hora
      });
    }
    );
    }


  

  List<Widget> creaHoras(fecha, fechaSelect, horaSelect, hora_inicio, num_horas) {
    List<Widget> lista = new List();
    DateFormat format = new DateFormat("MM/dd/yyy HH:mm");
    DateTime fecha_actual = format.parse("$fecha $hora_inicio");
    var hora_actual;

    for(var i=0; i < num_horas; i++) {
      hora_actual = DateFormat("HH:mm").format(fecha_actual);
      horaSelect = hora_actual;
      listaHoras.add(horaSelect);

      lista.add(Card(
        child:
          ListTile(
            title: Text(hora_actual),
            enabled: !reservas[hora_actual],
            onTap: ()
            {              
               mostrarDialogo(fecha_actual, fechaSelect, listaHoras.elementAt(i));
               print(fecha_actual);
            },
          ),
      ),
      );
      fecha_actual = fecha_actual.add(new Duration(minutes: 30));
    }
    return lista;
  }

  void mostrarDialogo(fecha,fechaSelect, horaSelect){
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
                 print(horaSelect);
                 Navigator.of(context).pop();
                 Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                       new Misreservas()
                      ));
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
       }
     );
  }


  Future<bool> isHora(fecha, hora) async {
    return Firestore.instance
        .collection('reservas')
        .where("fecha", isEqualTo: fecha)
        .where("hora", isEqualTo: hora)
        .getDocuments()
        .then((reservas) {
          return reservas.documents.length>0;
    });
  }

  
@override
  Widget build(BuildContext context) {

  DateTime fechaPicker = DateTime.now();

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
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                       new Misreservas()
                      ));
              }
            )
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
                      creaHoras(fecha, fecha, horaSelect , '08:30', 12);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
                },
                child: Column(children: <Widget>[
                  Text(fecha),
                    Text(
                  'Selecciona la fecha',
                  style: TextStyle(color: Colors.white
                                  ),
                )
                ],) 
                
                ),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: creaHoras('01/01/1990', fecha, horaSelect, '08:30', 12))
            )
          ],
        ),
      ),
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class Reserves extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _State();
// }

// class _State extends State<Reserves> {
//   String fecha;
//   bool _hora830 = false;
//   bool _hora900 = false;
//   bool _hora930 = false;
//   bool _hora1000 = false;
//   bool _hora1030 = false;
//   bool _hora1100 = false;
//   bool _hora1130 = false;
//   bool _hora1200 = false;
//   bool _hora1230 = false;
//   bool _hora1300 = false;
//   bool _hora1330 = false;
//   bool _hora1400 = false;


//   @override
//   initState() {
//     super.initState();
//     _hora830 = false;
//     _hora900 = false;
//     _hora930 = false;
//     _hora1000 = false;
//     _hora1030 = false;
//     _hora1100 = false;
//     _hora1130 = false;
//     _hora1200 = false;
//     _hora1300 = false;
//     _hora1330 = false;
//     _hora1400 = false;
//   }
  

//   Future<int> isHora(fecha, hora) async {
//     return Firestore.instance
//         .collection('reservas')
//         .where("fecha", isEqualTo: fecha)
//         .where("hora", isEqualTo: hora)
//         .getDocuments()
//         .then((reservas) {
//       print(reservas.documents.length);
//       return reservas.documents.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reservar'),
//       ),
//       body:
//       Container(
//         padding: EdgeInsets.all(32.0),
//         child: ListView(
//           children: <Widget>[
//             FlatButton(
//                 onPressed: () {
//                   DatePicker.showDatePicker(context,
//                       showTitleActions: true,
//                       minTime: DateTime(2019, 1, 1),
//                       maxTime: DateTime(2019, 12, 31), onChanged: (date) {
//                     print('change $date');
//                   }, onConfirm: (date) {
//                     fecha = DateFormat.yMd().format(date).toString();
//                     setState(() {
//                       isHora(fecha, '8:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora830 = true;
//                           } else {
//                             _hora830 = false;
//                           }
//                         });
//                       });
//                        isHora(fecha, '9:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora900 = true;
//                           } else {
//                             _hora900 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '9:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora930 = true;
//                           } else {
//                             _hora930 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '10:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1000 = true;
//                           } else {
//                             _hora1000 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '10:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1030 = true;
//                           } else {
//                             _hora1030 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '11:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1100 = true;
//                           } else {
//                             _hora1100 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '11:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1130 = true;
//                           } else {
//                             _hora1130 = false;
//                           }
//                         });
//                       });
//                        isHora(fecha, '12:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1200 = true;
//                           } else {
//                             _hora1200 = false;
//                           }
//                         });
//                       });
//                        isHora(fecha, '12:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1230 = true;
//                           } else {
//                             _hora1230 = false;
//                           }
//                         });
//                       });
//                        isHora(fecha, '13:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1300 = true;
//                           } else {
//                             _hora1300 = false;
//                           }
//                         });
//                       });
//                        isHora(fecha, '13:30').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1330 = true;
//                           } else {
//                             _hora1330 = false;
//                           }
//                         });
//                       });
//                       isHora(fecha, '14:00').then((resultado) {
//                         setState(() {
//                           if (resultado == 0) {
//                             _hora1400 = true;
//                           } else {
//                             _hora1400 = false;
//                           }
//                         });
//                       });
//                     });
//                     // mostrar(DateFormat.yMd().format(date));
//                   }, currentTime: DateTime.now(), locale: LocaleType.es);
//                 },
//                 child: Text(
//                   'Selecciona la fecha',
//                 )),
//             Card(
//               child: ListTile(
//                 title: Text('8:30'),
//                 enabled: _hora830,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('9:00'),
//                 enabled: _hora900,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('9:30'),
//                 enabled: _hora930,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('10:00'),
//                 enabled: _hora1000,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('10:30'),
//                 enabled: _hora1030,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('11:00'),
//                 enabled: _hora1100,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('11:30'),
//                 enabled: _hora1130,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('12:00'),
//                 enabled: _hora1200,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('12:30'),
//                 enabled: _hora1230,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('13:00'),
//                 enabled: _hora1300,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('13:30'),
//                 enabled: _hora1330,
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text('14:00'),
//                 enabled: _hora1400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
