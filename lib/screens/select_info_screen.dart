import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khu_meet/screens/landing_screen.dart';
import 'package:khu_meet/service/get_department.dart';
import 'package:khu_meet/screens/join_screen.dart';

class SelectInfoPage extends StatefulWidget {
  final String email;
  final String univ;
  const SelectInfoPage({required this.email, required this.univ});
  @override
  State<StatefulWidget> createState() {
    return _SelectInfoPageWidget();
  }
}

class _SelectInfoPageWidget extends State<SelectInfoPage>{
  List<String> MBTI = ["INTJ","INTP","ENTJ", "ENTP", "INFJ", "INFP", "ENFJ", "ENFP", "ISTJ", "ISFJ", "ESTJ", "ESFJ","ISTP", "ISFP", "ESTP", "ESFP"];
  List<int> studentID = [15, 16, 17, 18, 19, 20, 21, 22, 23, 24];
  String? selectMBTI;
  int? selectStudentID;
  bool selectCollege = false;
  String? college;
  String? depart;

  void updateCollege(bool newData, String newCollege, String newDepart){
    setState(() {
      selectCollege = newData;
      college = newCollege;
      depart = newDepart;

    });
  }

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
              children: <Widget>[
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
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                          child: Text("학과 정보", style: TextStyle(
                              fontSize: 20, fontFamily: "title", color: Colors.white
                          ),),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 400,
                          height: 125,
                          child: getDepartment(dataChanged : updateCollege)),
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
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          child: DropdownButton(
                              hint: Text("MBTI를 선택하세요", style: TextStyle(color: Colors.white),),
                              icon: (null),
                              value: selectMBTI,
                              items: MBTI.toSet().map((e){
                                return DropdownMenuItem(value: e, child: Text(e,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),),);}).toList(),
                              isExpanded: false,
                              dropdownColor: Colors.black.withOpacity(0.3),
                              onChanged: (value){
                                setState(() {
                                  selectMBTI = value;
                                });
                              }),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                          child: Text("학번", style: TextStyle(
                              fontSize: 20, fontFamily: "title", color: Colors.white
                          ),),
                        ),
                        //학번 작성 폼
                        Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: 30),
                          child: DropdownButton(
                              hint: Text("학번을 선택하세요", style: TextStyle(color: Colors.white),),
                              icon: (null),
                              value: selectStudentID,
                              items: studentID.toSet().map((e){
                                return DropdownMenuItem(value: e, child: Text(e.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),),);}).toList(),
                              isExpanded: false,
                              dropdownColor: Colors.black.withOpacity(0.3),
                              onChanged: (value){
                                setState(() {
                                  selectStudentID = value;
                                });
                              }),
                        ),
                        ElevatedButton(onPressed: (){
                          if(selectStudentID != null && selectMBTI != null && selectCollege) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JoinPage(email: widget.email, univ: widget.univ, mbti: selectMBTI!, studentId: selectStudentID!, college: college!, depart: depart! )));
                              }else{
                            showDialog(context: context,
                                builder: (context)=> AlertDialog(
                                    title: Text("모두 선택해주세요"),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text("확인"))]
                                ));
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
                        child: Text("다음")),
                      ],
                    ),
                  ),
              ],
          )
      ),
    )
    );
  }
}