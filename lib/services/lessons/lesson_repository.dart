import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/lessons/lesson_provider.dart';
import 'package:workbook/models/lesson.dart';

class LessonRepository {
  final LessonProvider _provider = LessonProvider();

// - DML -
  Future createRecord(Map<String, dynamic> fieldsMap) async =>
      await _provider.createRecord(fieldsMap);

  Future editRecord(String id, Map<String, dynamic> data) async =>
      await _provider.editRecord(id, data);

  Future deleteRecord(String id) async => await _provider.deleteRecord(id);

  Future upsertRecord(bool isNew, Lesson lesson) async {
    if (isNew) {
      await createRecord(lesson.toMap());
    } else {
      await editRecord(lesson.id!, lesson.toMap());
    }
  }

// - QUERY RECORDS -
  Future<List<Lesson>> queryAllLessons() async {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) return Future.value([]);
    return await _provider.queryLessons({_provider.fTeacherId: teacherId});
  }
}
