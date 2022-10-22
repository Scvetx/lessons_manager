/* Custom Widget - a button used in the bottom of the screen
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class BottomButtonCmp extends StatelessWidget {
  final String title;
  final Color color;
  final GestureTapCallback? onPressed;

  const BottomButtonCmp(
      {required this.title,
      this.color = defaultButtonColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color.withOpacity(0.5),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
