import 'package:flutter/material.dart';
import 'package:khu_meet/screens/login_screen.dart';
import 'package:khu_meet/screens/landing_screen.dart';

class JoinCompletePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        body: Container (
            width: double.infinity,
            height: Size.infinite.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffDCD0FF),
                  Color(0xffFAACA8)
                ],
              ),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100, bottom: 100),
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white, width: 3), top: BorderSide(color: Colors.white, width: 3)),
                  ),
                  child: Text('  회원가입에\n성공하였습니다',
                    style: TextStyle(fontSize: 43, color: Colors.white, fontFamily: 'title',height: 2.3, letterSpacing: 3),),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        minimumSize: Size(220, 50),
                        textStyle: TextStyle(fontSize: 17,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                    child: Text("로그인"),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    },
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Text("메인 화면으로"),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Landing())
                    );
                  },
                ),
              ],
            )
        )
    );
  }
}