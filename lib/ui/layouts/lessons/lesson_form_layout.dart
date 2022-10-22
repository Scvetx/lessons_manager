/* A form where a teacher can create/edit a lesson
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_wrap.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/form/form_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/language_level/language_levels_buttons_row_cmp.dart';
import 'package:workbook/ui/components/courses/courses_buttons_row_cmp.dart';

class LessonFormLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonFormBloc bloc = BlocProvider.of<LessonFormBloc>(context);
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
            selectedValue: formWrap.lesson.languageLevel.value,
            onSelect: (String value) {
              formWrap.lesson.languageLevel.value = value;
            }),
        const SizedBox(height: spaceBetweenLinesLarge),
        CoursesButtonsRowCmp(
          selectedCoursesNames: formWrap.lesson.coursesNames.values,
        ),
      ])),
      bottomNavigationBar:
          BottomButtonCmp(title: labelSave, onPressed: bloc.toSave),
    );
  }
}
