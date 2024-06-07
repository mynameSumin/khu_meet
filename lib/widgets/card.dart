import 'package:flutter/material.dart';
import 'package:khu_meet/widgets/elevator_button.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final String text;
  final String selection;
  final ValueChanged<String> onSelect;

  CardWidget({required this.index, required this.selection, required this.text, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    List<String> options = selection.split(' vs ');

    return Center(
      child: Container(
        width: 260,
        height: 300,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.7,
              letterSpacing: 1.2,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
            SizedBox(height: 20),
            ElevatorButton(
              label: options[0],
              onPressed: () => onSelect(options[0]),
            ),
            SizedBox(height: 10),
            ElevatorButton(
              label: options[1],
              onPressed: () => onSelect(options[1]),
            ),
          ]
        ),
      ),
    );
  }
}
