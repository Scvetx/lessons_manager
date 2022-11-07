/* functions to process dml/queried students
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/students/student_provider.dart';
import 'package:workbook/services/courses_attendees/course_attendee_repository.dart';

import 'package:workbook/models/cobject.dart';
import 'package:workbook/models/student.dart';
import 'package:workbook/models/course_attendee.dart';
import 'package:workbook/constants/labels.dart';

class StudentRepository {
  final StudentProvider _provider = StudentProvider();
  final CourseAttendeeRepository _attendeeRepo = CourseAttendeeRepository();

// ----- DML: STUDENT -----
  // create a new user and 1 student related to the user
  Future createStudentAndUser(Student newStudent) async {
    // create user
    User? newUser = await FirebaseAuthService.createUserWithoutSigningIn(
        newStudent.email.value, newStudent.firstLoginPassword!);
    //create student
    if (newUser != null) {
      newStudent.userId = newUser.uid;
      String studentId = await _provider.createRecord(newStudent.toMap());
      // create related courses attendees
      if (newStudent.courses != null && newStudent.courses!.isNotEmpty) {
        _setStudentIdToRelatedCourses(studentId, newStudent.courses!);
        await _attendeeRepo.createRecords(newStudent.courses!);
      }
    } else {
      // TODO: add custom errors & labels
      throw Exception('Error occurred while creating a user.');
    }
  }

  // update 1 student
  Future updateRecord(Student newStudent, Student oldStudent) async {
    // update/create/delete courses attendees
    await _refreshRelatedCourses(newStudent, oldStudent);
    // update student
    await _provider.updateRecord(newStudent.id!, newStudent.toMap());
  }

  // clear teacherId field on the student
  Future deactivateStudent(Student student) async {
    // we don't delete student: only deactivate it
    Student newStudent = student.copy(isActive: false);
    await updateRecord(newStudent, student);
  }

// ----- DML: RELATED RECORDS -----
  // set student id on courses attendees after the student is created
  void _setStudentIdToRelatedCourses(
      String studentId, List<CourseAttendee> newCoursesAttendees) {
    for (CourseAttendee attendee in newCoursesAttendees) {
      attendee.studentId = studentId;
    }
  }

  // if student's courses list was changed => update/create/delete courses attendees
  Future _refreshRelatedCourses(Student newStudent, Student oldStudent) async {
    // if list of student's courses is changed  => create/delete courses attendees
    if (newStudent.courses != oldStudent.courses) {
      await _createAndDeleteRelatedCourses(newStudent, oldStudent);
    }
  }

  // create/delete courses attendees basing on student's refreshed courses list
  Future _createAndDeleteRelatedCourses(
      Student newStudent, Student oldStudent) async {
    // map course id => course attendee
    Map<String, CourseAttendee> newAttendeesMap = {
      for (var v in newStudent.courses!) v.courseId!: v
    };
    Map<String, CourseAttendee> oldAttendeesMap = {
      for (var v in oldStudent.courses!) v.courseId!: v
    };
    // define which course attendees need to be created/deleted
    Set<String> newCoursesIds = newAttendeesMap.keys.toSet();
    Set<String> oldCoursesIds = oldAttendeesMap.keys.toSet();
    Set<String> deleteCoursesIds = oldCoursesIds.difference(newCoursesIds);
    Set<String> createCoursesIds = newCoursesIds.difference(oldCoursesIds);
    // create/delete courses attendees
    if (deleteCoursesIds.isNotEmpty) {
      Set<String> attendeesIdsToDelete = {
        for (var attendee in oldAttendeesMap.values)
          if (deleteCoursesIds.contains(attendee.courseId)) attendee.id!
      };
      await _attendeeRepo.deleteRecordsByIds(attendeesIdsToDelete);
    }
    if (createCoursesIds.isNotEmpty) {
      List<CourseAttendee> attendeesToCreate = [
        for (var attendee in newAttendeesMap.values)
          if (createCoursesIds.contains(attendee.courseId)) attendee
      ];
      await _attendeeRepo.createRecords(attendeesToCreate);
    }
  }

// ----- QUERY: STUDENTS -----
  // query all active students related to the teacher
  Future<List<Student>> queryAllActiveStudents() async =>
      await _provider.queryStudents(filtersAllActiveStudents);

  // get filters: 1) related to the teacher 2) isActive = true
  List<QueryFilter> get filtersAllActiveStudents {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) throw Exception(errNotLoggedIn);
    return [IsActiveQueryFilter(true), TeacherIdQueryFilter(teacherId)];
  }

// ----- QUERY: RELATED RECORDS -----
  // query <courses_attendees> records related to a student
  Future<List<CourseAttendee>> queryRelatedCourses(String studentId) =>
      _attendeeRepo.queryCoursesAttendeesByStudentId(studentId);

// ----- FILTER RECORDS -----
  List<Student> filterStudentsByIds(List<Student> students, Set<String> ids) {
    List<CObject> cObjects = _provider.filterCObjectsByIds(students, ids);
    List<Student> filteredStudents =
        cObjects.map((cObj) => cObj as Student).toList();
    return filteredStudents;
  }
}
