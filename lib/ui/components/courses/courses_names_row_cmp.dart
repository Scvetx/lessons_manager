/* Custom Widget - a list of courses presented as text in one row
*/

import 'package:flutter/material.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/courses/course_repository.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/constants/styles/object_view_style.dart';

class CoursesNamesRowCmp extends StatelessWidget {
  final Set<String> coursesIds;

  CoursesNamesRowCmp({required this.coursesIds});

  Future<List<Course>> get courses async {
    CourseRepository repository = CourseRepository();
    List<Course> allCourses = await repository.queryAllCourses();
    return repository.filterCoursesByIds(allCourses, coursesIds!);
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return Container();

    return FutureBuilder<List<Course>>(
        future: courses,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (!snapshot.hasData) return Container();

          return Wrap(runSpacing: 14, children: [
            for (int i = 0; i < snapshot.data!.length; i++)
              Text(
                  '${snapshot.data![i].name.value}${i < snapshot.data!.length - 1 ? ',   ' : ''}',
                  style: ovCoursesNamesStyle)
          ]);
        });
  }
}
