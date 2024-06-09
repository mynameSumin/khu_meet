import 'package:flutter/material.dart';
import '../models/options.dart';

class PercentageBar extends StatelessWidget {
  final List<Option> label;
  final List<double?> percentages; // percentage를 nullable로 변경

  PercentageBar({required this.label, required this.percentages});

  @override
  Widget build(BuildContext context) {
    List<String> options = [label[0].optionText, label[1].optionText];

    if (options.length != percentages.length) {
      throw ArgumentError("The number of options and percentages must be equal.");
    }

    return Column(
      children: List.generate(options.length, (index) {
        return Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment.center,
              child: Text(
                options[index],
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
                    widthFactor: percentages[index] ?? 0.0,
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
            Container(
              width: 55,
              child: Text(
                percentages[index] == null
                    ? '?? %'
                    : '${(percentages[index]! * 100).toStringAsFixed(0)} %',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      }),
    );
  }
}
