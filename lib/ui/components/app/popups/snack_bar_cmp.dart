/* Custom Widget - a snackbar to show user platform messages in the app
*/

import 'package:flutter/material.dart';

class SnackBarCmp extends SnackBar {
  final String text;

  SnackBarCmp({required this.text})
      : super(
          content: Text(text),
          backgroundColor: Colors.grey.withOpacity(0.3),
        );
}
