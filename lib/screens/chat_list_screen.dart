import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chatUsers = [
    {"name": "김○○", "message": "그러자", "image": "assets/user1.jpg"},
    {"name": "이○○", "message": "내일 뭐해?", "image": "assets/user2.jpg"},
    {"name": "박○○", "message": "난 수업 왔어", "image": "assets/user3.jpg"},
    {"name": "김○○", "message": "안녕하세요!", "image": "assets/user4.jpg"},
    {"name": "배○○", "message": "네!", "image": "assets/user5.jpg"},
    {"name": "강○○", "message": "그럼 시간 언제 되세요?", "image": "assets/user6.jpg"},
    {"name": "조○○", "message": "", "image": "assets/user7.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('경희대학교'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search chats',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chatUsers[index]["image"]!),
                  ),
                  title: Text(chatUsers[index]["name"]!),
                  subtitle: Text(chatUsers[index]["message"]!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(user: chatUsers[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
