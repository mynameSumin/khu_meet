import 'package:flutter/material.dart';

class PercentageBar extends StatelessWidget {
  final String label;
  final double percentage;

  PercentageBar({required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    List<String> options = label.split(' vs ');

    return Column(
      children: options.map((option) {
        return Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment.center,
              child: Text(
                option,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Text(
              '${(percentage * 100).toStringAsFixed(0)} %',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        );
      }).toList(),
    );
  }
}
