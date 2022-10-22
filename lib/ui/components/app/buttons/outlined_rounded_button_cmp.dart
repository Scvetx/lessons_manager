/* Custom Widget - a button with rounded borders and white background
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class OutlinedRoundedButtonCmp extends StatelessWidget {
  final String title;
  final GestureTapCallback onPressed;

  OutlinedRoundedButtonCmp({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: defaultButtonPadding,
        side: const BorderSide(color: defaultButtonColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(roundedButtonRadius)),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            color: defaultButtonColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
