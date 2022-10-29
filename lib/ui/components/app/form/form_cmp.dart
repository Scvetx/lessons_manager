/* Custom Widget - a list of text inputs used to create/edit records
*/

import 'package:flutter/material.dart';
import 'package:workbook/models/cfield.dart';
import 'package:workbook/ui/components/app/text/text_input_cmp.dart';
import 'package:workbook/constants/styles/app_style.dart';

class FormCmp extends StatefulWidget {
  Map<String, TextCField> fieldsMap;
  FormCmp(this.fieldsMap);

  @override
  _Form_cmpState createState() => _Form_cmpState();
}

class _Form_cmpState extends State<FormCmp> {
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (TextCField textField in widget.fieldsMap.values)
            Column(children: [
              TextInputCmp(
                  placeholder: textField.label,
                  curValue: textField.value,
                  length: textField.maxLength,
                  onChange: (value) {
                    setState(() {
                      textField.value = value;
                    });
                  }),
              const SizedBox(
                height: spaceBetweenLines,
              ),
            ]),
        ]);
  }
}
