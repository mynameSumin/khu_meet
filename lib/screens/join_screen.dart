import 'package:flutter/material.dart';

class JoinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JoinPageWidget();
  }
}

class _JoinPageWidget extends State<JoinPage>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("학교를 인증해주세요"),
              Text("학교 이름"),
              TextField(),
              Text("학교 이메일"),
              TextField(),
              OutlinedButton(onPressed: ()=> Navigator.of(context).pop(),
                  child: Text("<"))
            ],
          ),
        ),
      )
    );
  }
}