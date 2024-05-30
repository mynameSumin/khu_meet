import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//나중에 지우기
import 'package:khu_meet/screens/join_screen.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String? id;
  String? password;

  logIn(String? schoolEmail) async {
    print("onPressPost 함수 실행");
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : 'application/json'
    };
    http.Response response = await client.post(
        Uri.parse('https://univcert.com/api/v1/status'),
        body: json.encode({'key': "0e97ecba-18d9-4f74-b9e4-52df58a8917e",
          "email": schoolEmail,}),
        headers: headers
    );

    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> list = jsonDecode(responseBody);

    if(list['success'] == true){
      print("응답 : ${response.body}");
      showDialog(context: context,
          builder: (context)=> AlertDialog(
              title: Text("로그인에 성공하였습니다"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinPage())
                  );
                }, child: Text("확인"))]
          ));
    }else if(list['success'] == 400){
      print(list['message']);
      showDialog(context: context,
          builder: (context)=> AlertDialog(
              title: Text(list['message']),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("확인"))]
          ));
      print(responseBody);
    }else{
      print("다른 응답이 도착했습니다");
      showDialog(context: context,
          builder: (context)=> AlertDialog(
              title: Text(list['message']),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("확인"))]
          ));
      print(responseBody);
    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset : false,
          body:
          Container(
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.white, width: 2), ),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30, top: 40, right: 30),
                  child: TextButton(onPressed: ()=> Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                      ),
                      child: Text("< 돌아가기",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 30),
                  child: Text("로그인",
                    style: TextStyle(fontSize: 50, fontFamily: 'title',height: 1.7, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                          child: Text("학교 이메일", style: TextStyle(
                              fontSize: 25, fontFamily: "title", color: Colors.white
                          ),),
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.2),
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                            hintText: "이메일을 입력하세요",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value){
                            if(value?.isEmpty ?? false){
                              return "아이디를 입력해주세요";
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            id = value;
                          },
                        ),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                        //   child: Text("비밀번호", style: TextStyle(
                        //       fontSize: 25, fontFamily: "title", color: Colors.white
                        //   ),),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 50),
                        //   child: TextFormField(
                        //     style: TextStyle(
                        //         color: Colors.white
                        //     ),
                        //     decoration: InputDecoration(
                        //       filled: true,
                        //       fillColor: Colors.black.withOpacity(0.2),
                        //       hintText: "비밀번호를 입력하세요",
                        //       hintStyle: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //       contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //     ),
                        //     validator: (value){
                        //       if(value?.isEmpty ?? false){
                        //         return "비밀번호를 입력해주세요";
                        //       }
                        //       return null;
                        //     },
                        //     onSaved: (String? value){
                        //       password = value;
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState?.validate() ?? false){
                    _formKey.currentState?.save();
                    print("아이디 : $id, 비밀번호 : $password");
                    logIn(id);
                  }
                },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        minimumSize: Size(220, 50),
                        textStyle: TextStyle(fontSize: 17,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                    child: Text("로그인")),
              ],
            ),
          ),
        )
    );
  }
}