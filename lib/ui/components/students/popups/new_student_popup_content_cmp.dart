/* Custom Widget - new student: popup content
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_wrap.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/labels.dart';

class NewStudentPopupContentCmp extends StatelessWidget {
  final BuildContext formContext;
  NewStudentPopupContentCmp({required this.formContext});

  @override
  Widget build(BuildContext context) {
    final StudentFormBloc bloc = BlocProvider.of<StudentFormBloc>(formContext);
    final StudentFormWrap formWrap = bloc.state.formWrap!;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(labelNewStudentPopupText, style: sGreyText),
            ),
            const SizedBox(height: spaceBetweenLines),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(labelUserLogin, style: mGreyLabel)),
                    Text(formWrap.student.email.value, style: mGreyText),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(Profile.fPasswordLabel, style: mGreyLabel)),
                    Text(formWrap.student.firstLoginPassword!,
                        style: mGreyText),
                  ]),
            ),
            const SizedBox(height: spaceBetweenLines),
          ],
        ),
      ),
    );
  }
}
