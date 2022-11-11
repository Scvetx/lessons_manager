/* Custom Widget - a list of language levels presented as buttons in a row
*   (available language levels list is constant)
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/language_levels.dart';
import 'package:workbook/ui/components/app/data_buttons/index.dart';

class LanguageLevelsButtonsRowCmp extends StatelessWidget {
  final String? label;
  final Function isSelected;
  final Function onSelect;

  LanguageLevelsButtonsRowCmp(
      {this.label, required this.isSelected, required this.onSelect});

  List<ButtonWrap> get buttons => [
        for (var langLevel in languageLevels)
          ButtonWrap(
              key: langLevel.value,
              label: langLevel.value,
              selected: isSelected(langLevel.value),
              onSelect: onSelect)
      ];

  @override
  Widget build(BuildContext context) {
    return ButtonsRowCmp(label: label, buttons: buttons);
  }
}
