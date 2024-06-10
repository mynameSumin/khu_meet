import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'example_chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chatUsers = [
    {"name": "김○○", "message": "헉 신기하네요!", "image": "assets/images/cat.jpeg"},
    {"name": "이○○", "message": "내일 뭐해?", "image": "assets/user2.jpg"},
    {"name": "박○○", "message": "난 수업 왔어", "image": "assets/user3.jpg"},
    {"name": "김○○", "message": "안녕하세요!", "image": "assets/user4.jpg"},
    {"name": "배○○", "message": "네!", "image": "assets/user5.jpg"},
    {"name": "강○○", "message": "그럼 시간 언제 되세요?", "image": "assets/user6.jpg"},
    {"name": "조○○", "message": "ㅋㅋㅋㅋ", "image": "assets/user7.jpg"},
  ];

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
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white, width: 2)),
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 30, top: 60, right: 30, bottom: 5),
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text("경희대학교",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),)),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search chats',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatUsers.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 1)),
                    ),
                    margin: EdgeInsets.only(left: 30, right: 40),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(chatUsers[index]["image"]!),
                      ),
                      title: Text(chatUsers[index]["name"]!, style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      subtitle: Text(chatUsers[index]["message"]!, style: TextStyle(
                          color: Colors.black38.withOpacity(0.9)
                      ),),
                      onTap: () {
                        if (chatUsers[index] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExampleChatScreen()),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}