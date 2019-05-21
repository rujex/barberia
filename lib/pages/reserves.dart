import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/crudmethods.dart';


class Reserves extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Reserves> {

  crudmethods crudObj = new crudmethods();
    
    static DateTime _date = new DateTime.now();
    TimeOfDay _time = new TimeOfDay.now();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020),
        selectableDayPredicate: (DateTime val) =>
            val.weekday == 6 || val.weekday == 7 ? false : true,
      );

      if(picked != null && picked != _date) {
        print('Fecha seleccionada: ${_date.toString()}');
        setState(() {
          _date = picked;
        });
      }

    }

    Future<Null> _selectTime(BuildContext context) async{
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
      );

      if(picked != null && picked != _time) {
        print('Hora seleccionada: ${_time.toString()}');
        setState(() {
          _time = picked;
        });
      }

    }


  asd(){
    // String filtro = Firestore.instance.collection('reservas').where("fecha", isEqualTo: _date.toString()).toString();
    // if(filtro != null){
    //     print(filtro);
    // }else{
    //   print('no existe la fecha seleccionada en firebase');
    // }

    print('holaaaa');
  
  }    



 String filtro = Firestore.instance.collection('reservas').where("fecha", isEqualTo: _date.toString()).toString();



  comprobar(){
    if(filtro == null){
      dialogo();
    }else{
      print("OCUPAOOOOOOOOOOOOOOOOOO");
    }
  }


  void dialogo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("pruebaaa"),
          content: Text("asdasdasd"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          );
      }
    );
  }


    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar'),
      ),
      body: ListView(
        children: <Widget>[
          Text('Fecha seleccionada: ${_date.toString()}'),
          RaisedButton(
             child: Text('Seleccionar fecha'),
             onPressed: (){ _selectDate(context);}
          ),
          Card(child: ListTile(title: Text('8:30'),onTap: comprobar),),
          Card(child: ListTile(title: Text('9:00'),),),
          Card(child: ListTile(title: Text('9:30'),),),
          Card(child: ListTile(title: Text('10:00'),),),
          Card(child: ListTile(title: Text('10:30'),),),
          Card(child: ListTile(title: Text('11:00'),),),
          Card(child: ListTile(title: Text('11:30'),),),
          Card(child: ListTile(title: Text('12:00'),),),
          Card(child: ListTile(title: Text('12:30'),),),
          Card(child: ListTile(title: Text('13:00'),),),
          Card(child: ListTile(title: Text('13:30'),),),
          Card(child: ListTile(title: Text('14:00'),),),
        ],
      )
    );}

}
    
  //   @override
  //  Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Reservar'),
  //       ),
  //       body: Container(
  //         padding: EdgeInsets.all(32.0),
  //         child: Column(
  //           children: <Widget>[
  //             Text('Fecha seleccionada: ${_date.toString()}'),
  //             RaisedButton(
  //               child: Text('Seleccionar fecha'),
  //               onPressed: (){ _selectDate(context);}
  //               ),
  //               Text(''),
  //               Text('Hora seleccionada: ${_time.toString()}'),
  //               RaisedButton(
  //                child: Text('Seleccionar hora'),
  //                onPressed: (){
  //                   _selectTime(context);
  //                }
  //               ),
  //               RaisedButton(
  //                child: Text('Aceptar'),
  //                onPressed: (){
  //                   crudObj.addData({
  //                     'fecha': _date.toString(),
  //                     'hora': _time.toString()
  //                   });
  //                }
  //               )
  //           ],
  //         ),
  //       ),
  //     );
  //   }