/* Custom Widget - a list of courses component
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_bloc.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_wrap.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/list/list_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class CoursesListCmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CoursesListBloc bloc = BlocProvider.of<CoursesListBloc>(context);
    final CoursesListWrap listWrap = bloc.state.listWrap!;

    return ListCmp(rows: [
      for (Course curCourse in listWrap.courses)
        InkWell(
          onTap: () => bloc.toViewRecord(curCourse),
          child: Row(children: [
            Expanded(
              child: Flex(direction: Axis.horizontal, children: [
                Flexible(
                  child: Text(
                    curCourse.name.value,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: mBlackText,
                  ),
                ),
              ]),
            ),
            Visibility(
              visible: FirebaseAuthService.isTeacher,
              child: EditButtonCmp(
                onPressed: () => bloc.toEditRecord(curCourse),
              ),
            ),
          ]),
        ),
    ]);
  }
}
