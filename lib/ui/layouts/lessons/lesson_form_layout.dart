/* A Layout fot lesson_form_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_wrap.dart';
import 'package:workbook/models/lesson.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/form/form_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/language_level/language_levels_buttons_row_cmp.dart';
import 'package:workbook/ui/components/courses/courses_buttons_row_cmp.dart';
import 'package:workbook/ui/components/app/data_buttons/button_wrap.dart';

class LessonFormLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonFormBloc bloc = BlocProvider.of<LessonFormBloc>(context);
    if (bloc.state.formWrap == null) return Container();
    final LessonFormWrap formWrap = bloc.state.formWrap!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${formWrap.isNew ? labelNew : labelEdit} ${Lesson.label}'),
      ),
      body: ScreenContainerCmp(
          child: Column(children: [
        FormCmp(formWrap.fieldsMap),
        LanguageLevelsButtonsRowCmp(
          label: '${Lesson.fLanguageLevelLabel}: ',
          isSelected: (val) => formWrap.lesson.languageLevel.value == val,
          onSelect: (ButtonWrap btn) {
            formWrap.lesson.languageLevel.value = btn.key;
          },
        ),
        const SizedBox(height: spaceBetweenLinesLarge),
        CoursesButtonsRowCmp(
          multipleSelect: false,
          isSelected: (String courseId) => formWrap.lesson.courseId == courseId,
          onSelect: (ButtonWrap btn) {
            formWrap.lesson.courseId = btn.key;
            formWrap.lesson.course = btn.data as Course;
          },
        ),
      ])),
      bottomNavigationBar:
          BottomButtonCmp(title: labelSave, onPressed: bloc.toSave),
    );
  }
}
