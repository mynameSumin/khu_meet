import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children:[
              Text("login page"),
              OutlinedButton(onPressed: ()=> Navigator.of(context).pop(),
                  child: Text("<"))
            ]
          )
      )

      )
    );
  }
}