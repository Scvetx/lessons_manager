/* functions to process dml/queried lessons
*/

import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/lessons/lesson_provider.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/models/cobject.dart';
import 'package:workbook/models/lesson.dart';

class LessonRepository {
  final LessonProvider _provider = LessonProvider();

// ----- DML: LESSON -----
  // create 1 lesson
  Future createRecord(Lesson lesson) async =>
      await _provider.createRecord(lesson.toMap());
  // update 1 lesson
  Future updateRecord(Lesson lesson) async =>
      await _provider.updateRecord(lesson.id!, lesson.toMap());
  // delete 1 lesson
  Future deleteRecord(Lesson lesson) async =>
      await _provider.deleteRecord(lesson.id!);

// ----- QUERY: LESSONS -----
  // query all lessons related to the teacher
  Future<List<Lesson>> queryAllLessons() async =>
      await _provider.queryLessons(filtersAllActiveLessons);

  // get filters: 1) related to the teacher 2) isActive = true
  List<QueryFilter> get filtersAllActiveLessons {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) throw Exception(errNotLoggedIn);
    return [TeacherIdQueryFilter(teacherId)];
  }

  Future<List<Lesson>> queryLessonsByCourseId(String courseId) async {
    List<QueryFilter> filters = [CourseIdQueryFilter(courseId)];
    return _provider.queryLessons(filters);
  }

// ----- FILTER RECORDS -----
  List<Lesson> filterLessonsByIds(List<Lesson> lessons, Set<String> ids) {
    List<CObject> cObjects = _provider.filterCObjectsByIds(lessons, ids);
    List<Lesson> filteredLessons =
        cObjects.map((cObj) => cObj as Lesson).toList();
    return filteredLessons;
  }
}
