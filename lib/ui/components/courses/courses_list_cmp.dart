import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_bloc.dart';

import 'package:workbook/models/course.dart';
import 'package:workbook/ui/components/app/list/list_cmp.dart';

class CoursesListCmp extends StatelessWidget {
  final List<Course> courses;
  const CoursesListCmp({required this.courses});

  @override
  Widget build(BuildContext context) {
    final CoursesListBloc bloc = BlocProvider.of<CoursesListBloc>(context);
    return ListCmp(rows: [
      for (Course curCourse in courses)
        InkWell(
          onTap: () {
            bloc.toViewRecord(curCourse);
          },
          child: Row(children: [
            Expanded(
              child: Flex(direction: Axis.horizontal, children: [
                Flexible(
                  child: Text(
                    curCourse.name.value,
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
                  bloc.toEditRecord(curCourse);
                },
              ),
            ),
          ]),
        ),
    ]);
  }
}
