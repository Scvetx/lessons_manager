/* Custom Widget - the main menu shown in the AppBar
*/

import 'package:flutter/material.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/models/lesson.dart';
import 'package:workbook/models/profile.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/ui/screens/profile//profile_view_screen.dart';
import 'package:workbook/ui/screens/lessons/lessons_screen.dart';
import 'package:workbook/ui/screens/courses/courses_screen.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';

class AppMenuCmp extends StatelessWidget {
  static String? curTab;

  final List<PopupMenuItem> menu = [
    const PopupMenuItem<String>(
      value: ProfileViewScreen.id,
      child: Text('$labelMy ${Profile.label}'),
    ),
    const PopupMenuItem<String>(
      value: LessonsScreen.id,
      child: Text(Lesson.labelPlural),
    ),
    const PopupMenuItem<String>(
      value: CoursesScreen.id,
      child: Text(Course.labelPlural),
    ),
    const PopupMenuItem<String>(
      value: StudentsScreen.id,
      child: Text(Student.labelPlural),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    navigateToScreen(String screenId) {
      curTab = screenId;
      Navigator.popAndPushNamed(context, screenId);
    }

    return PopupMenuButton(
      constraints: const BoxConstraints(
        minWidth: 150,
      ),
      itemBuilder: (context) => menu,
      onSelected: (val) => navigateToScreen(val.toString()),
    );
  }
}
