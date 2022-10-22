import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_wrap.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';

class LessonViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonViewBloc bloc = BlocProvider.of<LessonViewBloc>(context);
    final LessonViewWrap viewWrap = bloc.state.viewWrap!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Lesson.label),
      ),
      body: ScreenContainerCmp(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(viewWrap.lesson.name.value, style: ovTitleMediumStyle),
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
          Wrap(runSpacing: 14, children: [
            for (int i = 0; i < viewWrap.lesson.coursesNames.values.length; i++)
              Text(
                  '${viewWrap.lesson.coursesNames.values[i]}${i < viewWrap.lesson.coursesNames.values.length - 1 ? ',   ' : ''}',
                  style: ovCoursesNamesStyle),
          ]),
        ]),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: '$labelDelete ${Lesson.label}',
          color: Colors.redAccent,
          onPressed: bloc.toDelete),
    );
  }
}
