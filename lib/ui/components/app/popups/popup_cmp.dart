import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'popup_wrap.dart';
import 'icon_close_cmp.dart';

class PopupCmp extends StatelessWidget {
  final PopupWrap wrap;
  PopupCmp({required this.wrap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: defaultHeaderColor,
        titlePadding: const EdgeInsets.all(14),
        contentPadding: const EdgeInsets.all(5),
        actionsPadding: const EdgeInsets.all(14),
        title: Stack(children: [
          Align(
            alignment: Alignment.topRight,
            child: IconCloseCmp(),
          ),
          wrap.title,
        ]),
        content: wrap.content,
        actions: [wrap.actions]);
  }
}
