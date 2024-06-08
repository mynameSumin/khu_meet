import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, String> user;

  ChatScreen({required this.user});

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
                Text('컴퓨터공학과', style: TextStyle(fontSize: 12)),
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
                _buildChatBubble('안녕하세요~', true),
                _buildChatBubble('저랑 취향이 비슷하시네요!', true),
                _buildChatBubble('오 정말요?', false),
                _buildChatBubble('몇 개나 같았나요?', false),
                _buildChatBubble('저랑 5개 중에 4개나 같아요!', true),
                _buildChatBubble('헉 신기하네요!', false),
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

  Widget _buildChatBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.black : Colors.grey[300],
          borderRadius: isMe
              ? BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )
              : BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
