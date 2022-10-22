/* Custom Widget - the main menu shown in the AppBar
*/

import 'package:flutter/material.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/models/lesson.dart';
import 'package:workbook/models/profile.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/ui/screens/profile//profile_view_screen.dart';
import 'package:workbook/ui/screens/schedule/schedule_screen.dart';
import 'package:workbook/ui/screens/lessons/lessons_screen.dart';
import 'package:workbook/ui/screens/courses/courses_screen.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';

class AppMenuCmp extends StatelessWidget {
  static int? curTab;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        constraints: const BoxConstraints(
          minWidth: 150,
        ),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('$labelMy ${Profile.label}'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Schedule'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text(Lesson.labelPlural),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Text(Course.labelPlural),
            ),
            const PopupMenuItem<int>(
              value: 4,
              child: Text(Student.labelPlural),
            ),
          ];
        },
        onSelected: (value) {
          //if (curTab != value) {
          curTab = value;
          if (value == 0) {
            // Profile
            Navigator.popAndPushNamed(context, ProfileViewScreen.id);
          } else if (value == 1) {
            // Schedule
            Navigator.popAndPushNamed(context, ScheduleScreen.id);
          } else if (value == 2) {
            // Lessons
            Navigator.popAndPushNamed(context, LessonsScreen.id);
          } else if (value == 3) {
            // Courses
            Navigator.popAndPushNamed(context, CoursesScreen.id);
          } else if (value == 4) {
            // Students
            Navigator.popAndPushNamed(context, StudentsScreen.id);
          }
          // }
        });
  }
}
