/* Custom Widget - a container with edge padding for screens
*/

import 'package:flutter/material.dart';

import 'package:workbook/constants/styles/app_style.dart';

class ScreenContainerCmp extends StatelessWidget {
  final Widget child;
  ScreenContainerCmp({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: screenPadding, child: child);
  }
}
