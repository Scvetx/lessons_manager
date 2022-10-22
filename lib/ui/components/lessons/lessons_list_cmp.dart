import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_bloc.dart';

import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/ui/components/app/list/list_cmp.dart';
import 'package:workbook/ui/components/app/text/text_in_circle_cmp.dart';

class LessonsListCmp extends StatelessWidget {
  final List<Lesson> lessons;
  const LessonsListCmp({required this.lessons});

  @override
  Widget build(BuildContext context) {
    final LessonsListBloc bloc = BlocProvider.of<LessonsListBloc>(context);
    return ListCmp(rows: [
      for (Lesson curLesson in lessons)
        InkWell(
          onTap: () {
            bloc.toViewRecord(curLesson);
          },
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
                  child: Text(
                    curLesson.name.value,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                iconSize: 16,
                onPressed: () {
                  bloc.toEditRecord(curLesson);
                },
              ),
            ),
          ]),
        ),
    ]);
  }
}
