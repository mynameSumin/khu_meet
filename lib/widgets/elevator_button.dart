import 'package:flutter/material.dart';

class ElevatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  ElevatorButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200,50),
        foregroundColor: Colors.blue, // 버튼 색상
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
