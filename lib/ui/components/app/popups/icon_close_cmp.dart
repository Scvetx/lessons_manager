import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class IconCloseCmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: const Icon(Icons.close, color: greyIconColor, size: 22),
    );
  }
}
