/* Custom Widget - a listRow used in ListCmp custom widget
*/

import 'package:flutter/material.dart';

class ListRowCmp extends StatelessWidget {
  final Widget row;

  ListRowCmp({required this.row});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width, child: row);
  }
}
