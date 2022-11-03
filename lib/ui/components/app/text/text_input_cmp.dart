/* Custom Widget - text input used in forms
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';

class TextInputCmp extends StatefulWidget {
  final String placeholder;
  String curValue;
  int? length;
  var onChange = (String value) {};

  TextInputCmp(
      {required this.placeholder,
      required this.curValue,
      this.length,
      required this.onChange});

  @override
  _TextInput_cmpState createState() => _TextInput_cmpState();
}

class _TextInput_cmpState extends State<TextInputCmp> {
  late TextEditingController _controller;

  int get minLines => widget.length == null || widget.length! <= 50
      ? 1
      : widget.length! <= 100
          ? 2
          : 5;
  TextInputType get inputType => widget.length == null || widget.length! <= 50
      ? TextInputType.text
      : TextInputType.multiline;

  void initController() {
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
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _controller,
        //maxLength: widget.length, // doesn't work in android: replaced with controller listener
        textAlign: TextAlign.left,
        minLines: minLines,
        maxLines: minLines + 5,
        keyboardType: inputType,
        decoration: inputTextDecoration.copyWith(hintText: widget.placeholder),
      )
    ]);
  }
}
