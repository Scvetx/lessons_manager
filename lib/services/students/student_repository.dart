import 'package:firebase_auth/firebase_auth.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/students/student_provider.dart';
import 'package:workbook/models/student.dart';

class StudentRepository {
  final StudentProvider _provider = StudentProvider();

// - DML -
  Future createStudentAndUser(Student student) async {
    User? newUser = await FirebaseAuthService.createUserWithoutSigningIn(
        student.email.value);
    if (newUser != null) {
      student.userId = newUser.uid;
      await _provider.createRecord(student.toMap());
    } else {
      // TODO: add custom errors & labels
      throw Exception('Error occurred while creating a user.');
    }
  }

  Future editRecord(String id, Map<String, dynamic> data) async =>
      await _provider.editRecord(id, data);

  Future upsertRecord(bool isNew, Student student) async {
    if (isNew) {
      await createStudentAndUser(student);
    } else {
      await editRecord(student.id!, student.toMap());
    }
  }

  Future removeTeacherId(Student student) async {
    // unlink student from the teacher
    String id = student.id!;
    student.teacherId = '';
    Map<String, dynamic> data = student.toMap();
    await editRecord(id, data);
  }

// - QUERY RECORDS -
  Future<List<Student>> queryAllStudents() async {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) return Future.value([]);
    return await _provider.queryStudents({_provider.fTeacherId: teacherId});
  }
}
