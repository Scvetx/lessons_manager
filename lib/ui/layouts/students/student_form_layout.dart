/* A Layout fot student_form_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_wrap.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';

import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/form/form_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/language_level/language_levels_buttons_row_cmp.dart';
import 'package:workbook/ui/components/courses/courses_buttons_row_cmp.dart';
import 'package:workbook/ui/components/app/data_buttons/button_wrap.dart';

class StudentFormLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StudentFormBloc bloc = BlocProvider.of<StudentFormBloc>(context);
    if (bloc.state.formWrap == null) return Container();
    final StudentFormWrap formWrap = bloc.state.formWrap!;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('${formWrap.isNew ? labelNew : labelEdit} ${Student.label}'),
      ),
      body: ScreenContainerCmp(
        child: Column(children: [
          FormCmp(formWrap.fieldsMap),
          LanguageLevelsButtonsRowCmp(
            label: '${Student.fLanguageLevelLabel}: ',
            isSelected: (val) => formWrap.student.languageLevel.value == val,
            onSelect: (ButtonWrap btn) {
              formWrap.student.languageLevel.value =
                  btn.selected ? btn.key : '';
            },
          ),
          const SizedBox(height: spaceBetweenLines),
          LanguageLevelsButtonsRowCmp(
            label: '${Student.fGoalLabel}: ',
            isSelected: (val) => formWrap.student.goal.value == val,
            onSelect: (ButtonWrap btn) {
              formWrap.student.goal.value = btn.selected ? btn.key : '';
            },
          ),
          const SizedBox(height: spaceBetweenLines),
          CoursesButtonsRowCmp(
            multipleSelect: true,
            isSelected: (val) => formWrap.student.containsCourse(val),
            onSelect: (ButtonWrap btn) {
              if (btn.selected) {
                formWrap.student.addCourse(btn.key);
              } else {
                formWrap.student.removeCourse(btn.key);
              }
            },
          ),
        ]),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: labelSave,
          onPressed: formWrap.isNew ? bloc.toNewStudentPopup : bloc.toSave),
    );
  }
}
