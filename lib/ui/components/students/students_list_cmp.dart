/* Custom Widget - a list of students component
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/students_list/students_list_bloc.dart';
import 'package:workbook/bloc/students/students_list/students_list_wrap.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/list/list_cmp.dart';
import 'package:workbook/ui/components/app/text/text_in_circle_cmp.dart';

class StudentsListCmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StudentsListBloc bloc = BlocProvider.of<StudentsListBloc>(context);
    final StudentsListWrap listWrap = bloc.state.listWrap!;

    return ListCmp(rows: [
      for (Student curStudent in listWrap.students)
        InkWell(
          onTap: () => bloc.toViewRecord(curStudent),
          child: Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextInCircleCmp(
                    text: curStudent.languageLevel?.value ?? ''),
              ),
            ),
            Expanded(
              child: Flex(direction: Axis.horizontal, children: [
                Flexible(
                  child: Text(curStudent.name.value,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: mBlackText),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 16,
                onPressed: () => bloc.toEditRecord(curStudent),
              ),
            ),
          ]),
        ),
    ]);
  }
}
