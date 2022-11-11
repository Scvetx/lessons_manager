/* Custom Widget - a list of lessons component
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_bloc.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_wrap.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/list/list_cmp.dart';
import 'package:workbook/ui/components/app/text/text_in_circle_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class LessonsListCmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonsListBloc bloc = BlocProvider.of<LessonsListBloc>(context);
    final LessonsListWrap listWrap = bloc.state.listWrap!;

    return ListCmp(rows: [
      for (Lesson curLesson in listWrap.lessons)
        InkWell(
          onTap: () => bloc.toViewRecord(curLesson),
          child: Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextInCircleCmp(text: curLesson.languageLevel.value),
              ),
            ),
            Expanded(
              child: Flex(direction: Axis.horizontal, children: [
                Flexible(
                  child: Text(curLesson.name.value,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: mBlackText),
                ),
              ]),
            ),
            Visibility(
              visible: FirebaseAuthService.isTeacher,
              child: EditButtonCmp(
                onPressed: () => bloc.toEditRecord(curLesson),
              ),
            ),
          ]),
        ),
    ]);
  }
}
