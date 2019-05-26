import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Reserves extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Reserves> {
  String fecha;
  bool _hora830 = false;
  bool _hora900 = false;
  bool _hora930 = false;
  bool _hora1000 = false;
  bool _hora1030 = false;
  bool _hora1100 = false;
  bool _hora1130 = false;
  bool _hora1200 = false;
  bool _hora1230 = false;
  bool _hora1300 = false;
  bool _hora1330 = false;
  bool _hora1400 = false;


  @override
  initState() {
    super.initState();
    _hora830 = false;
    _hora900 = false;
    _hora930 = false;
    _hora1000 = false;
    _hora1030 = false;
    _hora1100 = false;
    _hora1130 = false;
    _hora1200 = false;
    _hora1300 = false;
    _hora1330 = false;
    _hora1400 = false;
  }
  

  Future<int> isHora(fecha, hora) async {
    return Firestore.instance
        .collection('reservas')
        .where("fecha", isEqualTo: fecha)
        .where("hora", isEqualTo: hora)
        .getDocuments()
        .then((reservas) {
      print(reservas.documents.length);
      return reservas.documents.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar'),
      ),
      body:
      Container(
        padding: EdgeInsets.all(32.0),
        child: ListView(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2019, 1, 1),
                      maxTime: DateTime(2019, 12, 31), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    fecha = DateFormat.yMd().format(date).toString();
                    setState(() {
                      isHora(fecha, '8:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora830 = true;
                          } else {
                            _hora830 = false;
                          }
                        });
                      });
                       isHora(fecha, '9:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora900 = true;
                          } else {
                            _hora900 = false;
                          }
                        });
                      });
                      isHora(fecha, '9:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora930 = true;
                          } else {
                            _hora930 = false;
                          }
                        });
                      });
                      isHora(fecha, '10:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1000 = true;
                          } else {
                            _hora1000 = false;
                          }
                        });
                      });
                      isHora(fecha, '10:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1030 = true;
                          } else {
                            _hora1030 = false;
                          }
                        });
                      });
                      isHora(fecha, '11:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1100 = true;
                          } else {
                            _hora1100 = false;
                          }
                        });
                      });
                      isHora(fecha, '11:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1130 = true;
                          } else {
                            _hora1130 = false;
                          }
                        });
                      });
                       isHora(fecha, '12:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1200 = true;
                          } else {
                            _hora1200 = false;
                          }
                        });
                      });
                       isHora(fecha, '12:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1230 = true;
                          } else {
                            _hora1230 = false;
                          }
                        });
                      });
                       isHora(fecha, '13:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1300 = true;
                          } else {
                            _hora1300 = false;
                          }
                        });
                      });
                       isHora(fecha, '13:30').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1330 = true;
                          } else {
                            _hora1330 = false;
                          }
                        });
                      });
                      isHora(fecha, '14:00').then((resultado) {
                        setState(() {
                          if (resultado == 0) {
                            _hora1400 = true;
                          } else {
                            _hora1400 = false;
                          }
                        });
                      });
                    });
                    // mostrar(DateFormat.yMd().format(date));
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
                },
                child: Text(
                  'Selecciona la fecha',
                )),
            Card(
              child: ListTile(
                title: Text('8:30'),
                enabled: _hora830,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('9:00'),
                enabled: _hora900,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('9:30'),
                enabled: _hora930,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('10:00'),
                enabled: _hora1000,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('10:30'),
                enabled: _hora1030,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('11:00'),
                enabled: _hora1100,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('11:30'),
                enabled: _hora1130,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('12:00'),
                enabled: _hora1200,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('12:30'),
                enabled: _hora1230,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('13:00'),
                enabled: _hora1300,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('13:30'),
                enabled: _hora1330,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('14:00'),
                enabled: _hora1400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
