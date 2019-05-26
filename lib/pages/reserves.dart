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
  String hora;

  @override
   initState() {
     super.initState();
    isHora('5/22/2019', '8:30').then((resultado) {
      setState(() {
         hora = resultado;
      });
    });
  }


  isHora(fecha, hora) async {


         return Firestore.instance.collection('reserva')
                .where("fecha", isEqualTo: fecha)
                .where("hora", isEqualTo: hora)
                .snapshots();

            
  }


  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(


          children: <Widget>[

            RaisedButton(
              child: Text('Prueba'),
              onPressed: ()=> {

              isHora(fecha, hora).then((resultado){

                setState(() {

                 print(resultado.toString());

                   hora = resultado;

                });

              })
            },),




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
                      print("reconstruyendooooooo!!!!!!");
                    });
                    // mostrar(DateFormat.yMd().format(date));
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
                },
                child: Text(
                  'Selecciona la fecha',
                  style: TextStyle(color: Colors.blue),
                )),
            Card(
              child: ListTile(
                title: Text('8:30'),
                enabled: false,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('9:00'),
                enabled: false,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('9:30'),
                enabled: false,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('10:00'),
                enabled: false,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('10:30'),
                enabled: false,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('11:00'),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

