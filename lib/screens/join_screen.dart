import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khu_meet/screens/landing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  //이미지 업로드 위한 변수들
  final picker = ImagePicker();
  XFile? image;
  List<XFile?> multiImage = []; //갤러리에서 여러 사진 보여주는 것
  List<XFile?> images = []; //가져온 사진들 보여주기

  //학교 과 가져오는 함수
  bringDepart(String? school) async {
    print("과 가져오기 실행");
    var client = http.Client();
    var uri = "http://openapi.academyinfo.go.kr/openapi/service/rest/SchoolMajorInfoService/getSchoolMajorInfo";
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
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                            hintText: "자기 소개를 작성해주세요 (50자 이상)",
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
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(40, 30, 0, 10),
                  child: Text("사진", style: TextStyle(
                      fontSize: 20, fontFamily: "title", color: Colors.white
                  ),),
                ),
                //카메라로 촬영하기
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 40, right: 10, bottom: 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)
                            ],
                          ),
                          child: IconButton(
                              onPressed: () async {
                                image = await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
                                //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                                if (image != null) {
                                  setState(() {
                                    images.add(image);
                                    dynamic sendImage = image!.path;
                                  });
                                }
                              },
                              icon: Icon(Icons.add_a_photo, size: 30, color: Colors.white,)
                          )
                      ),
                      //갤러리에서 가져오기
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)],
                          ),
                          child: IconButton(
                              onPressed: () async {multiImage = await picker.pickMultiImage();
                              setState(() {
                                //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                                images.addAll(multiImage);
                              });
                              },
                              icon: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 30,
                                color: Colors.white,
                              )
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 120,
                      margin: EdgeInsets.all(10),
                      child: GridView.builder(padding: EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, //1 개의 행에 보여줄 사진 개수
                          childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                          mainAxisSpacing: 10, //수평 Padding
                          crossAxisSpacing: 10, //수직 Padding
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image:
                                    DecorationImage(
                                        fit: BoxFit.cover,  //사진 크기를 Container 크기에 맞게 조절
                                        image: FileImage(File(images[index]!.path   // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                        ))
                                    )
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  //삭제 버튼
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    icon: Icon(Icons.close,
                                        color: Colors.white,
                                        size: 15),
                                    onPressed: () {
                                      //버튼을 누르면 해당 이미지가 삭제됨
                                      setState(() {
                                        images.remove(images[index]);
                                      });
                                    },
                                  )
                              )
                            ],
                          );
                        },
                      ),
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
                    child: Text("완료")),

            ],
          ),
        )

      ),
    );
  }
}