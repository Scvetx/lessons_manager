/* Custom Widget - a list of buttons with data, presented in one row
*/

import 'package:flutter/material.dart';
import 'package:workbook/extensions/string_ext.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/data_buttons/index.dart';

class ButtonsRowCmp extends StatefulWidget {
  final String? label;
  final bool multipleSelect;
  late List<ButtonWrap> buttons;

  ButtonsRowCmp(
      // a user can select one value only
      {this.label,
      required this.buttons})
      : multipleSelect = false;

  ButtonsRowCmp.multiSelect(
      // a user can select a few values
      {this.label,
      required this.buttons})
      : multipleSelect = true;

  @override
  _ButtonsRowCmpState createState() => _ButtonsRowCmpState();
}

class _ButtonsRowCmpState extends State<ButtonsRowCmp> {
  // process on button selected depending on multipleSelect value
  void handleSelect(ButtonWrap selectedBtn) {
    setState(() {
      for (ButtonWrap btn in widget.buttons) {
        // unselect all other buttons  if multipleSelect = false
        if (!widget.multipleSelect &&
            btn.selected &&
            btn.key != selectedBtn.key) {
          btn.selected = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Wrap(spacing: 5, children: [
        Container(
            child: widget.label.isBlank
                ? Container()
                : SizedBox(
                    width: ovFirstColumnWidth,
                    child: Text(widget.label!),
                  )),
        for (ButtonWrap btn in widget.buttons)
          TextInCircleButtonCmp(btn: btn, onSelect: handleSelect)
      ]),
    );
  }
}
