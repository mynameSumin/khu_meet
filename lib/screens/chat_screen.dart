import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, String> user;

  ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(user["image"]!),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user["name"]!, style: TextStyle(fontSize: 16)),

              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                buildChatBubble('안녕하세요~', true),
                buildChatBubble('저랑 취향이 비슷하시네요!', true),
                buildChatBubble('오 정말요?', false),
                buildChatBubble('몇 개나 같았나요?', false),
                buildChatBubble('저랑 5개 중에 4개나 같아요!', true),
                buildChatBubble('헉 신기하네요!', false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '문자를 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
