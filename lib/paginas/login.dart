
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barberia/comportamientos/hiddenScrollBehavior.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  bool _estaLogueado = false;


  _login() async {

    if(_estaLogueado) return;
    setState(() {
      _estaLogueado = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuario logueado'),
    ));

    final form = _formKey.currentState;

    if(!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _estaLogueado = false;
      });
      return;
    }

    form.save();

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/main');
    } catch(e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Cancelar',
          onPressed: () {_scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() {
        _estaLogueado = false;
      });
    }

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    FlutterLogo(
                      style: FlutterLogoStyle.markOnly,
                      size: 200.0,
                    ),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Por favor escribe un email valido';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (val){
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Por favor escribe una contraseña valida';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (val){
                        setState(() {
                          _password = val;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('¡Bienvenidos a la barberia APP!',
                        style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                      ),
                    )
                  ],
                ),
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _login();
        },
        child: Icon(Icons.person_add),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/login');
          },
          child: Text('Ya tengo una cuenta'),
        )
      ],
    );
  }

  }