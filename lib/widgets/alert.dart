import 'package:flutter/material.dart';

// 알림 메시지 위젯 생성 함수
Widget alertMessage(String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(13),
      child: Row(
        children: [
          Icon(Icons.message, color: Colors.black), // 아이콘 색상 변경
          SizedBox(width: 10),
          Expanded(child: Text(message, style: TextStyle(color: Colors.black))), // 텍스트 색상 변경
        ],
      ),
    ),
  );
}
