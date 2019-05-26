import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Info extends StatelessWidget {
  static const String _title = 'La barbería';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
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


        Image.network('https://thebarbeer.co/wp-content/uploads/2018/05/barberia_05.jpg'),


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
            top: 20
          ),
          child: 
                Row(
                  
                  textDirection: TextDirection.ltr,

                  children: <Widget>[


                    Icon(
                           Icons.add,
                           color: Colors.pink,
                          size: 30.0,
                    ),
                    Icon(
                           Icons.add,
                           color: Colors.pink,
                          size: 30.0,
                    ),
                    Icon(
                           Icons.add,
                           color: Colors.pink,
                          size: 30.0,
                    ),


                  ],
                )
            


        ),
        


      ],

    );

  }

}