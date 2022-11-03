/* Custom Widget - clickable text
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class LinkText extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;

  LinkText({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: defaultButtonColor),
        ));
  }
}
