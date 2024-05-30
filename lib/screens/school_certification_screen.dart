import 'dart:convert';
import 'package:khu_meet/screens/join_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SchoolCertificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CerfPageWidget();
  }
}

class _CerfPageWidget extends State<SchoolCertificationPage>{
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? schoolName;
  String? email;
  String? cerf;

  //학교 인증 함수
  onPressPost(String? school, String? schoolEmail) async {
    print("onPressPost 함수 실행");
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : 'application/json'
    };

    var body = json.encode({
      'key': "0e97ecba-18d9-4f74-b9e4-52df58a8917e",
      'email': schoolEmail,
      'univName': school,
      'univ_check': true
    });

    // 디버깅을 위한 로그 출력
    print("Request Body: $body");

    try{
      http.Response response = await client.post(
        Uri.parse('https://univcert.com/api/v1/certify'),
        body: body,
        headers: headers,
      );

      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> list = jsonDecode(responseBody);

      if(list['success'] == true){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("인증번호가 이메일로 전송되었습니다"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              )
            ],
          ),
        );
      }else if(list['code'] == 400){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(list['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              )
            ],
          ),
        );
      }else{
        print("다른 응답이 도착했습니다");
        print("응답 : ${response.body}");
      }
    }finally {
      client.close();
    }
  }

  //인증 번호 확인
  void emailCerf(String? num, String? schoolEmail, String? school) async {
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : 'application/json'
    };

    var body = json.encode({
      'key': "0e97ecba-18d9-4f74-b9e4-52df58a8917e",
      'email': schoolEmail,
      'univName': school,
      'code': num,
    });

    // 디버깅을 위한 로그 출력
    print("Request Body: $body");

    try {
      http.Response response = await client.post(
        Uri.parse('https://univcert.com/api/v1/certifycode'),
        body: body,
        headers: headers,
      );

      var responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> list = jsonDecode(responseBody);

      // 디버깅을 위한 응답 출력
      print("Response: ${responseBody}");

      if (list['success'] == true) {
        print("응답 : ${responseBody}");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("인증되었습니다"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinPage()),
                  );
                },
                child: Text("확인"),
              )
            ],
          ),
        );
      } else if (list['code'] == 400) {
        print(responseBody);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("인증번호가 올바르지 않습니다"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              )
            ],
          ),
        );
      } else {
        print("다른 응답이 도착했습니다");
        print("응답 : ${response.statusCode}");
        print("${response.body}");
      }
    } finally {
      client.close();
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
                    //돌아가기 버튼
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
                    //제목
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30),
                      child: Text("학교를\n인증해주세요",
                        style: TextStyle(fontSize: 40, fontFamily: 'title',height: 1.7, color: Colors.white),
                      ),
                    ),
                    //인증 폼
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            //학교 이름
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                              child: Text("학교 이름", style: TextStyle(
                                  fontSize: 20, fontFamily: "title", color: Colors.white
                              ),),
                            ),
                            //학교 이름 작성
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.2),
                                contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                hintText: "학교 이름을 입력하세요",
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
                                  return "학교 이름을 입력해주세요";
                                }else{
                                  schoolName = value;
                                }
                                return null;
                              },
                              onSaved: (String? value){
                                schoolName = value;
                              },
                            ),
                            //학교 이메일
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                              child: Text("학교 이메일", style: TextStyle(
                                  fontSize: 20, fontFamily: "title", color: Colors.white
                              ),),
                            ),
                            //학교 이메일 작성 폼
                            Container(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  hintText: "학교 이메일을 입력하세요",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value){
                                  if(value?.isEmpty ?? false){
                                    return "학교 이메일을 입력해주세요";
                                  }else{
                                    email = value;
                                  }
                                  return null;
                                },
                                onSaved: (String? value){
                                  email = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      if(_formKey1.currentState?.validate() ?? false){
                        _formKey1.currentState?.save();
                        print("학교 이름 : $schoolName, 학교 이메일 : $email");
                        onPressPost(schoolName, email);
                      }else{
                        print("not validate");
                      }
                    },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            minimumSize: Size(220, 45),
                            textStyle: TextStyle(fontSize: 17,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        ),
                        child: Text("인증 번호 보내기")),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: Form(
                        key: _formKey2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(40, 30, 0, 10),
                              child: Text("인증 번호", style: TextStyle(
                                  fontSize: 20, fontFamily: "title", color: Colors.white
                              ),),
                            ),
                            Container(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  hintText: "이메일을 확인하고 번호를 입력하세요",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value){
                                  if(value?.isEmpty ?? false){
                                    return "인증번호를 입력해주세요";
                                  }else{
                                    cerf = value;
                                  }
                                  return null;
                                },
                                onSaved: (String? value){
                                  cerf = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      if(_formKey2.currentState?.validate() ?? false){
                        _formKey2.currentState?.save();
                        print("학교 이름 : $schoolName, 학교 이메일 : $email, 인증번호: $cerf");
                        emailCerf(cerf, email, schoolName);
                      }else{
                        print("not validate");
                      }
                    },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            minimumSize: Size(220, 45),
                            textStyle: TextStyle(fontSize: 17,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        ),
                        child: Text("인증하기"))
                  ],
          ),
        ),
      )
    );
  }
}