import 'package:flutter/material.dart';


class Schedule extends StatelessWidget {
  static const String _title = 'Horario';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}


class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Horario de Lunes a Viernes'),
            subtitle: Text('Mañana: 8:30 - 14:00'),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Reservar cita'),
                  onPressed: () { Navigator.pushNamed(context, '/reservar'); },
                ),
                FlatButton(
                  child: const Text('Ubicación'),
                  onPressed: () { Navigator.pushNamed(context, '/localizacion'); },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}