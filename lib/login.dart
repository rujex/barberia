import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesion'),
      ),
      body: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if(input.isEmpty){
                      return 'Por favor escribe tu email';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    labelText: 'Email'
                  ),
                ),
                TextFormField(
                  validator: (input) {
                    if(input.length < 6){
                      return 'Tu contraseña necesita tener al menos 6 caracteres';
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                      labelText: 'Contraseña'
                  ),
                  obscureText: true, //oculta texto
                ),
              RaisedButton(
                onPressed: () {},
                child: Text('Iniciar Sesion'),
              )
            ],
          )
      ),
    );
  }

  void iniciarSesion(){
    //TODO validar campos
    final formEstado = _formkey.currentState;
    if(formEstado.validate()){
      //TODO iniciar sesion firebase
    }
  }
}
