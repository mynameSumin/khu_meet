import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  File? _image;

  // 갤러리에서 이미지 선택하는 함수
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 프로필'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // 프로필 이미지 위젯
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/default_profile.jpg') as ImageProvider,
              child: InkWell(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '컴퓨터공학과 xx학번\n민수민',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('로그아웃'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('정보 수정'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('소개 수정하기'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('보유 코인', style: TextStyle(fontSize: 16)),
                    Text('3개', style: TextStyle(fontSize: 16)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('추가 결제'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('선택한 취향', style: TextStyle(fontSize: 16)),
                    Text('15개', style: TextStyle(fontSize: 16)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('수정하기'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // 알림 리스트를 스크롤 가능하게 만들기
            Container(
              height: 300,
              child: ListView(
                children: [
                  _buildMessage('□ ◻님이 당신에게 채팅을 보내고 싶어합니다.'),
                  _buildMessage('ㄱㄷ ㅈ님이 메시지를 수락하였습니다.'),
                  _buildMessage('xxx님이 당신의 모든 프로필을 확인했습니다.'),
                  // 추가 알림 메시지
                  _buildMessage('새로운 알림 1'),
                  _buildMessage('새로운 알림 2'),
                  _buildMessage('새로운 알림 3'),
                  _buildMessage('새로운 알림 4'),
                  _buildMessage('새로운 알림 5'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 알림 메시지 위젯 생성 함수
  Widget _buildMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.message),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
