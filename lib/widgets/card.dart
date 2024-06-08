import 'package:flutter/material.dart';
import 'package:khu_meet/widgets/elevator_button.dart';
import '../models/options.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final String text;
  final List<Option> selection;
  final ValueChanged<String> onSelect;

  CardWidget({required this.index, required this.selection, required this.text, required this.onSelect});

  @override
  Widget build(BuildContext context) {

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
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
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
            ),
            SizedBox(height: 20),
            ElevatorButton(
              label: selection[0].optionText,
              onPressed: () => onSelect(selection[0].optionText),
            ),
            SizedBox(height: 10),
            ElevatorButton(
              label: selection[1].optionText,
              onPressed: () => onSelect(selection[1].optionText),
            ),
          ]
        ),
      ),
    );
  }
}
