/* Custom Widget - not clickable text in a circle
*/

import 'package:flutter/material.dart';

class TextInCircleCmp extends StatelessWidget {
  final String text;
  late Color frameColor;
  Color textColor;
  TextInCircleCmp(
      {required this.text,
      this.frameColor = Colors.grey,
      this.textColor = Colors.grey}) {
    frameColor = text == '' ? Colors.transparent : frameColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: frameColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
