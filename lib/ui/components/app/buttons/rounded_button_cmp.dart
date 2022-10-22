/* Custom Widget - a button with rounded borders
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class RoundedButtonCmp extends StatelessWidget {
  final Color color;
  final String title;
  final GestureTapCallback onPressed;

  RoundedButtonCmp(
      {required this.title,
      this.color = defaultButtonColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(roundedButtonRadius),
      child: MaterialButton(
        padding: defaultButtonPadding,
        onPressed: onPressed,
        child: Text(title, style: whiteText),
      ),
    );
  }
}
