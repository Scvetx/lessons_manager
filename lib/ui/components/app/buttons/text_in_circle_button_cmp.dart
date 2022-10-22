/* Custom Widget - a button presented as a text in a circle
*/

import 'package:flutter/material.dart';
import 'package:workbook/ui/components/app/text/text_in_circle_cmp.dart';

class TextInCircleButtonCmp extends StatefulWidget {
  final String text;
  late bool selected;
  var onSelect = (String value) {};
  TextInCircleButtonCmp(
      {required this.text, this.selected = false, required this.onSelect});
  @override
  _TextInCircleButton_cmpState createState() => _TextInCircleButton_cmpState();
}

class _TextInCircleButton_cmpState extends State<TextInCircleButtonCmp> {
  bool _hovered = false;

  void _onHover() => _hovered = true;
  void _onStopHover() => _hovered = false;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Colors.grey;
    Color selectedColor = Colors.orangeAccent;

    Color baseColor = widget.selected ? selectedColor : defaultColor;
    Color color = _hovered ? baseColor.withOpacity(0.7) : baseColor;

    return InkWell(
      onTap: () {
        setState(() {
          widget.selected = widget.selected == true ? false : true;
          widget.onSelect(widget.text);
        });
      },
      onHover: (value) {
        setState(() {
          if (value == true) {
            _onHover();
          } else {
            _onStopHover();
          }
        });
      },
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: TextInCircleCmp(
          text: widget.text, frameColor: color, textColor: color),
    );
  }
}
