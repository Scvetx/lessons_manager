/* functions to process dml/queried teachers
*/

import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/teachers/teacher_provider.dart';

import 'package:workbook/models/teacher.dart';

class TeacherRepository {
  final TeacherProvider _provider = TeacherProvider();
// ----- DML: TEACHER -----
  // create 1 teacher
  Future createRecord(Teacher newTeacher) async =>
      await _provider.createRecord(newTeacher.toMap());
  // update 1 teacher
  Future updateRecord(Teacher newTeacher) async {
    await _provider.updateRecord(newTeacher.id!, newTeacher.toMap());
  }

// ----- QUERY: TEACHERS -----
  // query teacher related to the userId
  Future<Teacher?> queryTeacherByUserId(String userId) async {
    List<QueryFilter> filters = [UserIdQueryFilter(userId)];
    List<Teacher> students = await _provider.queryTeachers(filters);
    return students.isNotEmpty ? students[0] : null;
  }
}
