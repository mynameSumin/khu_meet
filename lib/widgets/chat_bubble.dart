import "package:flutter/material.dart";

Widget buildChatBubble(String message, bool isMe) {
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
