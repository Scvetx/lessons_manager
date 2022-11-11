/* Custom Widget - new student: popup actions buttons
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_bloc.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/ui/components/app/buttons/outlined_rounded_button_cmp.dart';

class NewStudentPopupActionsCmp extends StatelessWidget {
  final BuildContext formContext;
  const NewStudentPopupActionsCmp({required this.formContext});

  @override
  Widget build(BuildContext context) {
    final StudentFormBloc bloc = BlocProvider.of<StudentFormBloc>(formContext);
    return OutlinedRoundedButtonCmp(
        title: labelContinue, onPressed: bloc.toSave);
  }
}
