/* Custom Widget - a picklist with List of String values
*/

import 'package:flutter/material.dart';

class PicklistCmp extends StatefulWidget {
  final List<String> picklistItems;
  String selectedValue;
  var onChanged = (String value) {};
  PicklistCmp(
      {required this.picklistItems,
      required this.selectedValue,
      required this.onChanged});

  @override
  _Picklist_cmpState createState() => _Picklist_cmpState();
}

class _Picklist_cmpState extends State<PicklistCmp> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButton<String>(
        value: widget.selectedValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          setState(() {
            widget.selectedValue = value!;
          });
          widget.onChanged(value!);
        },
        items:
            widget.picklistItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ]);
  }
}
