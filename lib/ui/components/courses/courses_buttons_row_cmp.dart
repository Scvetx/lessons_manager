/* Custom Widget - a list of courses presented as buttons in a row
*   (only courses added to the teacher's library are shown)
*/

import 'package:flutter/material.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/courses/course_repository.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/ui/components/app/data_buttons/index.dart';

class CoursesButtonsRowCmp extends StatelessWidget {
  final bool multipleSelect;
  final Function isSelected;
  final Function onSelect;

  CoursesButtonsRowCmp(
      {required this.multipleSelect,
      required this.isSelected,
      required this.onSelect});

  Future<List<Course>> get courses => CourseRepository().queryAllCourses();

  List<ButtonWrap> getButtons(List<Course> courses) => [
        for (var course in courses)
          ButtonWrap(
              key: course.id!,
              label: course.name.value,
              data: course,
              selected: isSelected(course.id),
              onSelect: onSelect)
      ];

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return Container();

    return FutureBuilder<List<Course>>(
        future: courses,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (!snapshot.hasData) return Container();

          if (multipleSelect) {
            return ButtonsRowCmp.multiSelect(
              label: null,
              buttons: getButtons(snapshot.data!),
            );
          } else {
            return ButtonsRowCmp(
              label: null,
              buttons: getButtons(snapshot.data!),
            );
          }
        });
  }
}
