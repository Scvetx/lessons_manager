/* A Layout fot lesson_view_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_wrap.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/text/description_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class LessonViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonViewBloc bloc = BlocProvider.of<LessonViewBloc>(context);
    if (bloc.state.viewWrap == null) return Container();
    final LessonViewWrap viewWrap = bloc.state.viewWrap!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Lesson.label),
      ),
      body: ScreenContainerCmp(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
                child: Text(viewWrap.lesson.name.value,
                    style: ovTitleMediumStyle)),
            Visibility(
              visible: FirebaseAuthService.isTeacher,
              child: Align(
                alignment: Alignment.topRight,
                child: EditButtonCmp(
                  onPressed: () => bloc.toEditRecord(),
                ),
              ),
            ),
          ]),
          Visibility(
            visible: viewWrap.lesson.description.value.isNotEmpty,
            child: Column(children: [
              const SizedBox(height: spaceBetweenLines),
              DescriptiontCmp(text: viewWrap.lesson.description.value),
            ]),
          ),
          const SizedBox(height: spaceBetweenLines),
          Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Text('${Lesson.fLanguageLevelLabel}:',
                  style: ovFieldLabelStyle),
            ),
            Text(viewWrap.lesson.languageLevel.value,
                style: ovLanguageLevelStyle),
          ]),
          const SizedBox(height: spaceBetweenLines),
          Visibility(
            visible: viewWrap.lesson.course != null,
            child: Text('${viewWrap.lesson.course?.name.value}',
                style: ovCoursesNamesStyle),
          ),
        ]),
      ),
      bottomNavigationBar: FirebaseAuthService.isTeacher
          ? BottomButtonCmp(
              title: '$labelDelete ${Lesson.label}',
              color: Colors.redAccent,
              onPressed: bloc.toDelete)
          : null,
    );
  }
}
