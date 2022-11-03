/* Custom Widget - grey small text
*/

import 'package:flutter/material.dart';

class DescriptiontCmp extends StatelessWidget {
  final String text;
  Color? color;
  DescriptiontCmp({required this.text, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }
}
