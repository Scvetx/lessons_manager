/* functions to process dml/queried lessons
*/

import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/lessons/lesson_provider.dart';

import 'package:workbook/models/dbobject.dart';
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
  Future<List<Lesson>> queryAllLessons() async => FirebaseAuthService.isTeacher
      ? await _provider
          .queryLessons([TeacherIdQueryFilter(FirebaseAuthService.teacherId!)])
      : await _provider.queryLessons([]);

  // query lessons by parent course id
  Future<List<Lesson>> queryLessonsByCourseId(String courseId) async {
    List<QueryFilter> filters = [CourseIdQueryFilter(courseId)];
    return _provider.queryLessons(filters);
  }

// ----- FILTER RECORDS -----
  List<Lesson> filterLessonsByIds(List<Lesson> lessons, Set<String> ids) {
    List<DBObject> dbObjects = _provider.filterDBObjectsByIds(lessons, ids);
    List<Lesson> filteredLessons =
        dbObjects.map((cObj) => cObj as Lesson).toList();
    return filteredLessons;
  }
}
