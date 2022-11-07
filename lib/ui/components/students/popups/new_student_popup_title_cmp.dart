import 'package:flutter/material.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/labels.dart';

class NewStudentPopupTitleCmp extends StatelessWidget {
  const NewStudentPopupTitleCmp();

  @override
  Widget build(BuildContext context) {
    return const Text(labelNewStudentPopupTitle, style: whiteText);
  }
}
