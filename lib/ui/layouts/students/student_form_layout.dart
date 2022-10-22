/* A form where a teacher can create/edit a lesson
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

class StudentFormLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StudentFormBloc bloc = BlocProvider.of<StudentFormBloc>(context);
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
              selectedValue: formWrap.student.languageLevel?.value,
              onSelect: (String value) {
                formWrap.student.languageLevel.value = value;
              }),
          const SizedBox(height: spaceBetweenLines),
          LanguageLevelsButtonsRowCmp(
              label: '${Student.fGoalLabel}: ',
              selectedValue: formWrap.student.goal?.value,
              onSelect: (String value) {
                formWrap.student.goal.value = value;
              }),
          const SizedBox(height: spaceBetweenLinesLarge),
          CoursesButtonsRowCmp(
              selectedCoursesNames: formWrap.student.coursesNames.values),
        ]),
      ),
      bottomNavigationBar:
          BottomButtonCmp(title: labelSave, onPressed: bloc.toSave),
    );
  }
}
