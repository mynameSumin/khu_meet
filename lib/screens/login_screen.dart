import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khu_meet/screens/home_screen.dart';
import 'package:khu_meet/service/user_api.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? email;
  String? univ;

  logIn(String? schoolEmail, String? univ) async {
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
      Future<Map<String, dynamic>?> userInfo = loginUser(schoolEmail!, univ!);
      print("응답 : ${response.body}");
      print("받아온 사용자 정보 : ${userInfo}");
      showDialog(context: context,
          builder: (context)=> AlertDialog(
              title: Text("로그인에 성공하였습니다"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(userInfo: userInfo, univ: univ))
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
                          child: Text("학교명", style: TextStyle(
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
                            hintText: "학교명을 입력하세요",
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
                              return "학교명을 입력해주세요";
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            univ = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 80),
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
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
                              return "이메일을 입력해주세요";
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            email = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState?.validate() ?? false){
                    _formKey.currentState?.save();
                    _formKey2.currentState?.save();
                    logIn(email, univ);
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