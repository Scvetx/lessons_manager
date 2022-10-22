/* Custom Widget - a list of language levels presented as buttons in a row
*   (available language levels list is not a subject to change)
*/

import 'package:flutter/material.dart';

import 'package:workbook/models/language_level.dart';
import 'package:workbook/ui/components/app/buttons/buttons_row_cmp.dart';

class LanguageLevelsButtonsRowCmp extends StatelessWidget {
  String? label;
  String? selectedValue;
  var onSelect = (String value) {};

  LanguageLevelsButtonsRowCmp(
      {this.label, this.selectedValue, required this.onSelect});

  Widget build(BuildContext context) {
    return ButtonsRowCmp(
        label: label,
        selectedValue: selectedValue,
        tagsList: LanguageLevel.getLanguageLevels(),
        onSelect: (String value) {
          selectedValue = value;
          onSelect(value);
        });
  }
}
