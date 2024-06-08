import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khu_meet/screens/landing_screen.dart';
import 'dart:io';
import 'package:khu_meet/widgets/alert.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  File? _image;

  // 갤러리에서 이미지 선택하는 함수
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffA3BDED),
              Color(0xff5A80B2),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 2)),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: 30, top: 60, right: 30, bottom: 5),
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: Text("경희대학교",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),)),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                padding: EdgeInsets.fromLTRB(10, 22, 20, 10),
                alignment: Alignment.center,
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        CircleAvatar(
                          radius: 50,
                          //backgroundImage: _image != null ? FileImage(_image!) : Text("hi") as ImageProvider,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '컴퓨터공학과 xx학번\n민수민',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight
                              .bold),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 프로필 이미지 위젯
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(20, 28),
                            padding: EdgeInsets.fromLTRB(15,6,15,6),
                            backgroundColor: Colors.grey.withOpacity(0.3), // 버튼 색상
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Landing())
                            );
                          },
                          child: Text('로그아웃', style: TextStyle(
                              fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(15,6,15,6),
                            minimumSize: Size(20, 28),
                            backgroundColor: Colors.grey.withOpacity(0.3), // 버튼 색상
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('정보 수정', style: TextStyle(
                              fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 320,
                height: 45,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(15,6,15,6),
                    minimumSize: Size(20, 28),
                    backgroundColor: Colors.black, // 버튼 색상
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    ),

                  ),
                  onPressed: () {},
                  child: Text('소개 수정하기', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18
                  ),),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 20),
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 0),
                      alignment: Alignment.center,
                      width: 155,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text('보유 코인', style: TextStyle(
                            fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                          Text('3개', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            fontSize: 12
                          ),),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 28),
                                padding: EdgeInsets.fromLTRB(15,6,15,6),
                                backgroundColor: Colors.grey.withOpacity(0.3), // 버튼 색상
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('추가 결제',style: TextStyle(
                                  fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 20, 20),
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 0),
                      alignment: Alignment.center,
                      width: 155,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text('선택한 취향', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                          Text('16개', style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 28),
                                padding: EdgeInsets.fromLTRB(15,6,15,6),
                                backgroundColor: Colors.grey.withOpacity(0.3), // 버튼 색상
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('수정하기',style: TextStyle(
                                  fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 알림 리스트를 스크롤 가능하게 만들기
              Container(
                width: 350,
                height: 300,
                child: ListView(
                  children: [
                    alertMessage('ㅁㅅㅁ님이 당신에게 채팅을 보내고 싶어합니다.'),
                    alertMessage('ㄱㄷㅈ님이 메시지를 수락하였습니다.'),
                    alertMessage('xxx님이 당신의 모든 프로필을 확인했습니다.'),
                    // 추가 알림 메시지
                    alertMessage('새로운 알림 1'),
                    alertMessage('새로운 알림 2'),
                    alertMessage('새로운 알림 3'),
                    alertMessage('새로운 알림 4'),
                    alertMessage('새로운 알림 5'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}