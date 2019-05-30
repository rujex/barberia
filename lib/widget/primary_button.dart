import 'package:flutter/material.dart';

// Clase que muestra un botón con diferentes características
class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.onPressed}) : super(key: key);
  final Key key;
  final String text;
  final double height;
  final VoidCallback onPressed;

  // construye el botón
  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: BoxConstraints.expand(height: height),
      child: new RaisedButton(
          child: new Text(text, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 2))),
          color: Colors.blue,
          textColor: Colors.black87,
          onPressed: onPressed),
    );
  }
}