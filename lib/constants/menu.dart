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

const List<PopupMenuItem> teacherMenu = [
  PopupMenuItem<String>(
    value: ProfileViewScreen.id,
    child: Text('$labelMy ${Profile.label}'),
  ),
  PopupMenuItem<String>(
    value: LessonsScreen.id,
    child: Text(Lesson.labelPlural),
  ),
  PopupMenuItem<String>(
    value: CoursesScreen.id,
    child: Text(Course.labelPlural),
  ),
  PopupMenuItem<String>(
    value: StudentsScreen.id,
    child: Text(Student.labelPlural),
  ),
];

const List<PopupMenuItem> studentMenu = [
  PopupMenuItem<String>(
    value: ProfileViewScreen.id,
    child: Text('$labelMy ${Profile.label}'),
  ),
  PopupMenuItem<String>(
    value: CoursesScreen.id,
    child: Text(Course.labelPlural),
  ),
];
