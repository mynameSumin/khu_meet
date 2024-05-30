import 'package:flutter/material.dart';
import 'package:khu_meet/screens/landing_screen.dart';

class JoinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JoinPageWidget();
  }
}

class _JoinPageWidget extends State<JoinPage>{
  String? introduction;
  String? MBTI;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Container(
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
                  margin: EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 5),
                  child: TextButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Landing())
                  );
                },
                    style: TextButton.styleFrom(
                    ),
                    child: Text("< home",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),)),
              ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 40),
                  child: Text("사용자에 대해\n알려주세요",
                    style: TextStyle(fontSize: 45, fontFamily: 'title',height: 1.5, color: Colors.white),
                  ),
                ),
                //인증 폼
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        //자기 소개
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                          child: Text("나의 소개", style: TextStyle(
                              fontSize: 20, fontFamily: "title", color: Colors.white
                          ),),
                        ),
                        //자기 소개 작성
                        TextFormField(
                          style: TextStyle(
                              color: Colors.white,
                          ),
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.2),
                            contentPadding: EdgeInsets.fromLTRB(15, 30, 10, 0),
                            hintText: "자기 소개를 작성해주세요",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value){
                            if(value?.isEmpty ?? false){
                              return "자기소개를 입력해주세요";
                            }else{
                              introduction = value;
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            introduction = value;
                          },
                        ),
                        //MBTI
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                          child: Text("MBTI", style: TextStyle(
                              fontSize: 20, fontFamily: "title", color: Colors.white
                          ),),
                        ),
                        //MBTI 작성 폼
                        Container(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "MBTI를 선택하세요",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value){
                              if(value?.isEmpty ?? false){
                                return "MBTI를 선택해주세요";
                              }else{
                                MBTI = value;
                              }
                              return null;
                            },
                            onSaved: (String? value){
                              MBTI = value;
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
                    print("자기소개 : $introduction, MBTI : $MBTI");
                    //onPressPost(schoolName, email);
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
                    child: Text("완료"))
            ],
          ),
        )

      ),
    );
  }
}