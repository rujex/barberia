import 'package:flutter/material.dart';
import '../rutas.dart';
import '../translations.dart';

class Horario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Horario"),
        ),
        body: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(Translations.of(context).text('schedules_2')),
                  subtitle: Text(Translations.of(context).text('schedules_3')),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Reservar cita'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/reservar');
                        },
                      ),
                      FlatButton(
                        child: const Text('Ubicación'),
                        onPressed: () {
                           Navigator.pushNamed(context, '/localizacion');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
