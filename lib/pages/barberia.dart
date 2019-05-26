import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Info extends StatelessWidget {
  static const String _title = 'La barbería';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
           leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),),
          )
          ,
        body: MyStatelessWidget(),
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
      )
    );
  }
}


class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(


      children: <Widget>[


        Image.network(
          'https://thebarbeer.co/wp-content/uploads/2018/05/barberia_05.jpg',
          ),


        Padding
              (
                
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: 
                  Text(
                    'Horario',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ,

              ),

        
        Padding(
        
          padding: EdgeInsets.only(
            top: 20
          ),
          child: 
          
           Text
                (
                    'Abrimos de Lunes a Viernes de 8:30 a 14:00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ) ,
                ) 


        ),

        
         Padding(
        
          padding: EdgeInsets.only(
            top: 20
          ),
          child: 
          
           Text
                (
                    'Redes Sociales',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ) ,
                ) 


        ),



         Padding(
        
          padding: EdgeInsets.only(
            top: 20,
            left: 40,
          ),
          child: 
                Row(
                  

                  children: <Widget>[


                    RaisedButton(
                      onPressed: () {},
                      child: Text('Instagram'),
                      color: Colors.deepOrange,
                      shape: Border.all(
                        width: 3,
                        color: Colors.white
                        ), 
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Twitter'),
                      color: Colors.blue,
                      shape: Border.all(
                        width: 3,
                        color: Colors.white
                        ), 
                    ),
                     Padding(
                      padding: EdgeInsets.only(
                        right: 10
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Youtube'),
                      color: Colors.red,
                      shape: Border.all(
                        width: 3,
                        color: Colors.white
                        ), 
                    ),


                  ],
                )
            


        ),
        
         Padding(
        
          padding: EdgeInsets.only(
            top: 20
          ),
          child: 

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on),

                  Text
                (
                   'Avenida de Cadiz, Córdoba',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ) ,
                ) 

              ],
          )
          
         

        ),



      ],

    );

  }

}