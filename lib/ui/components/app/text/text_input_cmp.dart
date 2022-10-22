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

  void initController() {
    _controller = TextEditingController.fromValue(
        TextEditingValue(text: widget.curValue));
    _controller.addListener(() {
      widget.curValue = _controller.text;
      widget.onChange(widget.curValue);
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
        maxLength: widget.length,
        keyboardType: TextInputType.name,
        textAlign: TextAlign.left,
        decoration: inputTextDecoration.copyWith(hintText: widget.placeholder),
      ),
    ]);
  }
}
