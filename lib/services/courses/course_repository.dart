import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/courses/course_provider.dart';
import 'package:workbook/models/course.dart';

class CourseRepository {
  final CourseProvider _provider = CourseProvider();

// - DML -
  Future createRecord(Map<String, dynamic> fieldsMap) async =>
      await _provider.createRecord(fieldsMap);

  Future editRecord(String id, Map<String, dynamic> data) async =>
      await _provider.editRecord(id, data);

  Future deleteRecord(String id) async => await _provider.deleteRecord(id);

  Future upsertRecord(bool isNew, Course course) async {
    if (isNew) {
      await createRecord(course.toMap());
    } else {
      await editRecord(course.id!, course.toMap());
    }
  }

// - QUERY RECORDS -
  Future<List<Course>> queryAllCourses() async {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) return Future.value([]);
    return await _provider.queryCourses({_provider.fTeacherId: teacherId});
  }

  Stream<Object?> queryAllCoursesStream() {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('courses')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots();
  }

// - HANDLE RECORDS LiST
  List<String> getNamesFromCoursesList(List<Course> courses) {
    List<String> names = [];
    for (Course course in courses) {
      names.add(course.name.value);
    }
    return names;
  }
}
