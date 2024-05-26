import 'package:flutter/material.dart';
import 'package:khu_meet/screens/login_screen.dart';
import 'package:khu_meet/screens/join_screen.dart';

class Landing extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        body: Container (
          width: 300,
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('" 경희의 \n       소개팅 "'),
              ElevatedButton(
                child: Text("시작하기"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
              ),
              ElevatedButton(
                child: Text("회원가입"),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage())
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}