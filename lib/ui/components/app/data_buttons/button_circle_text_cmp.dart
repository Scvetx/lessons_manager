/* Custom Widget - a button with data, presented as a text in a circle
*/

import 'package:flutter/material.dart';
import 'package:workbook/ui/components/app/text/text_in_circle_cmp.dart';
import 'package:workbook/ui/components/app/data_buttons/button_wrap.dart';

class TextInCircleButtonCmp extends StatefulWidget {
  final ButtonWrap btn;
  final Function? onSelect;
  TextInCircleButtonCmp({required this.btn, this.onSelect});
  @override
  _TextInCircleButtonCmpState createState() => _TextInCircleButtonCmpState();
}

class _TextInCircleButtonCmpState extends State<TextInCircleButtonCmp> {
  final Color defaultColor = Colors.grey;
  final Color selectedColor = Colors.orangeAccent;

  bool _hovered = false;

  void _onHover(bool hovered) =>
      setState(() => hovered ? _onStartHover() : _onStopHover());

  void _onStartHover() => _hovered = true;
  void _onStopHover() => _hovered = false;

  void _onSelect() {
    if (widget.onSelect != null) widget.onSelect!(widget.btn);
    setState(() => widget.btn.onSelect());
  }

  @override
  Widget build(BuildContext context) {
    Color baseColor = widget.btn.selected ? selectedColor : defaultColor;
    Color color = _hovered ? baseColor.withOpacity(0.7) : baseColor;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: _onSelect,
          onHover: _onHover,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: TextInCircleCmp(
              text: widget.btn.label, frameColor: color, textColor: color),
        ));
  }
}
