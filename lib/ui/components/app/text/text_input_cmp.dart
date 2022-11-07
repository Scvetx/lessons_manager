/* Custom Widget - text input used in forms
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/services/app/helpers/numbers_helper.dart';

class TextInputCmp extends StatefulWidget {
  final String placeholder;
  String curValue;
  int? length;
  int? maxNumberOfLines;
  var onChange = (String value) {};

  TextInputCmp(
      {required this.placeholder,
      required this.curValue,
      this.length,
      this.maxNumberOfLines,
      required this.onChange});

  @override
  _TextInput_cmpState createState() => _TextInput_cmpState();
}

class _TextInput_cmpState extends State<TextInputCmp> {
  late TextEditingController _controller;
  late int _minLines;
  late int _maxLines;

  void _initLinesLimits() {
    // get needed number of lines by text length limit
    int minNumberOfLines = _getMinNumberOfLinesByLength();
    // if max number of lines is defined for the input then ensure that it's not exceeded
    if (widget.maxNumberOfLines != null) {
      minNumberOfLines = NumbersHelper.getSmallestInt(
          widget.maxNumberOfLines!, minNumberOfLines);
    }
    _minLines = minNumberOfLines;
    _maxLines = widget.maxNumberOfLines ?? _minLines + 5;
  }

  int _getMinNumberOfLinesByLength() {
    int maxVal = 5;
    return widget.length == null
        // max number of lines if text length limit wasn't provided
        ? maxVal
        // 1 line if text length limit <= 50
        : widget.length! <= 50
            ? 1
            // 2 lines if text length limit <= 100
            : widget.length! <= 100
                ? 2
                // max number of lines if text length limit > 100
                : maxVal;
  }

  TextInputType get inputType => widget.length == null || widget.length! <= 50
      ? TextInputType.text
      : TextInputType.multiline;

  void _initController() {
    _controller = TextEditingController.fromValue(
        TextEditingValue(text: widget.curValue));

    _controller.addListener(() {
      if (_controller.text.length <= widget.length!) {
        widget.curValue = _controller.text;
        widget.onChange(widget.curValue);
      } else {
        _controller.text = widget.curValue;
      }
    });
  }

  @override
  void initState() {
    _initController();
    _initLinesLimits();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _controller,
        //maxLength: widget.length, // doesn't work in android: replaced with controller listener
        textAlign: TextAlign.left,
        minLines: _minLines,
        maxLines: _maxLines,
        keyboardType: inputType,
        decoration: inputTextDecoration.copyWith(hintText: widget.placeholder),
      )
    ]);
  }
}
