/* Custom Widget - a list of student_view presented as buttons in a row
*   (only student_view added to the teacher's library are shown)
*/

import 'package:flutter/material.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/courses/course_repository.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/ui/components/app/buttons/buttons_row_cmp.dart';

class CoursesButtonsRowCmp extends StatelessWidget {
  String? label;
  List<String>? selectedCoursesNames;
  CoursesButtonsRowCmp({this.label, this.selectedCoursesNames});

  Future<List<String>> get coursesNames async {
    CourseRepository courseRepository = CourseRepository();
    List<Course> courses = await courseRepository.queryAllCourses();
    List<String> coursesNames =
        courseRepository.getNamesFromCoursesList(courses);
    coursesNames.sort();
    return coursesNames;
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return Container();

    return FutureBuilder<List<String>>(
        future: coursesNames,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) return Container();
          return ButtonsRowCmp.multiSelect(
              label: label,
              tagsList: snapshot.data!,
              selectedValues: selectedCoursesNames,
              onSelect: (String value) {
                selectedCoursesNames ??= [];
                if (selectedCoursesNames!.contains(value)) {
                  selectedCoursesNames!.remove(value);
                } else {
                  selectedCoursesNames!.add(value);
                }
              });
        });
  }
}

/* the options with streams was replaced with the future option due to performance when loading widget
  Stream<QuerySnapshot<Map<String, dynamic>>> coursesSnapshots = (() {
    String teacherId = FirebaseAuthService.userId!;
    return FirebaseFirestore.instance
        .collection('courses')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots();
  })();


  @override
  Widget build(BuildContext context) {
      if (!FirebaseAuthService.loggedIn) return Container();

      return StreamBuilder(
          stream: coursesSnapshots,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var docs = snapshot.data?.docs;
            List<String> coursesNames = [];
            if (docs == null) return Container();
            for (QueryDocumentSnapshot<Object?> doc in docs!) {
              Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
              Course course = Course.fromMap(map);
              coursesNames.add(course.name.value);
            }
            coursesNames.sort();
            return ButtonsRowCmp.multiSelect(
                label: label,
                tagsList: coursesNames,
                selectedValues: selectedCoursesNames,
                onSelect: (String value) {
                  selectedCoursesNames ??= [];
                  if (selectedCoursesNames!.contains(value)) {
                    selectedCoursesNames!.remove(value);
                  } else {
                    selectedCoursesNames!.add(value);
                  }
                });
          });
      }
*/
