import 'package:flutter/material.dart';

class Horario extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horario"),
      ),
      body:
      Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Horario de Lunes a Viernes'),
                subtitle: Text('Mañana: 8:30 - 14:00   Tarde: 17:00 - 20:00'),
              ),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Reservar cita'),
                      onPressed: () { /* ... */ },
                    ),
                    FlatButton(
                      child: const Text('Ubicación'),
                      onPressed: () { /* ... */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      );
  }
  
}