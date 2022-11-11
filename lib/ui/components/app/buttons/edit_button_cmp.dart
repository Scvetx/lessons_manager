/* Custom Widget - a button used in the bottom of the screen
*/

import 'package:flutter/material.dart';

class EditButtonCmp extends StatelessWidget {
  final GestureTapCallback? onPressed;
  const EditButtonCmp({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.edit),
        iconSize: 16,
        onPressed: onPressed,
      ),
    );
  }
}
