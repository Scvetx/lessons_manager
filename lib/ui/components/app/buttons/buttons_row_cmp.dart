/* Custom Widget - a list of buttons presented in one row
*/

import 'package:flutter/material.dart';
import 'package:workbook/extensions/string_ext.dart';
import 'package:workbook/ui/components/app/buttons/text_in_circle_button_cmp.dart';
import 'package:workbook/constants/styles/object_view_style.dart';

class ButtonsRowCmp extends StatefulWidget {
  String? label;
  final bool multipleSelect;
  late List<String> tagsList;
  String? selectedValue;
  List<String>? selectedValues;
  var onSelect = (String value) {};

  ButtonsRowCmp(
      // a user can select one value only
      {this.label,
      required this.tagsList,
      this.selectedValue,
      required this.onSelect})
      : multipleSelect = false;

  ButtonsRowCmp.multiSelect(
      // a user can select a few values
      {this.label,
      required this.tagsList,
      this.selectedValues,
      required this.onSelect})
      : multipleSelect = true;

  @override
  _ButtonsRow_cmpState createState() => _ButtonsRow_cmpState();
}

class _ButtonsRow_cmpState extends State<ButtonsRowCmp> {
  late Set<String> _selectedValues;

  void initSelectedValues() {
    // set list of selected values for multiple select
    if (widget.multipleSelect && widget.selectedValues != null) {
      _selectedValues = widget.selectedValues!.toSet();
      // set one value for non multiple select
    } else if (!widget.multipleSelect && widget.selectedValue != null) {
      _selectedValues = {widget.selectedValue!};
      // init empty list ig no selected values were passes in the params
    } else {
      _selectedValues = {};
    }
  }

  onValueSelected(String value) {
    if (widget.multipleSelect) {
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    } else {
      _selectedValues = {value};
    }
  }

  @override
  void initState() {
    initSelectedValues();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Wrap(spacing: 7, children: [
          Container(
              child: widget.label.isBlank
                  ? Container()
                  : SizedBox(
                      width: ovFirstColumnWidth,
                      child: Text(widget.label!),
                    )),
          for (String text in widget.tagsList)
            TextInCircleButtonCmp(
                text: text,
                selected: _selectedValues.contains(text),
                onSelect: (String value) {
                  setState(() {
                    onValueSelected(value);
                  });
                  widget.onSelect(value);
                })
        ]));
  }
}
