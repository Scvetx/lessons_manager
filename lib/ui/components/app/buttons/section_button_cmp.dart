/* Custom Widget - a clickable section button on the screen
*/

import 'package:flutter/material.dart';

class SectionTitleButtonCmp extends StatelessWidget {
  final String title;
  final GestureTapCallback onPressed;

  SectionTitleButtonCmp({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(0.3),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          color: Colors.grey.withOpacity(0.05),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 1.5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
