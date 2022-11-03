/* functions to process dml/queried courses
*/

import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/courses/course_provider.dart';
import 'package:workbook/services/courses_attendees/course_attendee_repository.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/models/cobject.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/models/course_attendee.dart';

class CourseRepository {
  final CourseProvider _provider = CourseProvider();
  final CourseAttendeeRepository _attendeeRepo = CourseAttendeeRepository();

// ----- DML: COURSE -----
  // create 1 course
  Future createRecord(Course newCourse) async =>
      await _provider.createRecord(newCourse.toMap());

  // update 1 course
  Future updateRecord(Course newCourse, Course oldCourse) async {
    // update/create/delete courses attendees
    await _refreshRelatedCourses(newCourse, oldCourse);
    // update course
    await _provider.updateRecord(newCourse.id!, newCourse.toMap());
  }

  // delete 1 course
  Future deleteRecord(Course course) async {
    if (course.courseAttendees!.isNotEmpty) {
      Set<String> attendeesIds = {for (var v in course.courseAttendees!) v.id!};
      await _provider.deleteRecordsByIds(attendeesIds);
    }
    await _provider.deleteRecord(course.id!);
  }

// ----- DML: RELATED RECORDS -----
  // if courses_attendees list was changed => update/create/delete courses attendees
  Future _refreshRelatedCourses(Course newCourse, Course oldCourse) async {
    // if list of student's courses is changed  => create/delete courses attendees
    if (newCourse.courseAttendees != oldCourse.courseAttendees) {
      await _createAndDeleteRelatedCourses(newCourse, oldCourse);
    }
  }

  // create/delete courses_attendees basing on student's refreshed courses list
  Future _createAndDeleteRelatedCourses(
      Course newCourse, Course oldStudent) async {
    // map course id => course attendee
    Map<String, CourseAttendee> newAttendeesMap = {
      for (var v in newCourse.courseAttendees!) v.studentId!: v
    };
    Map<String, CourseAttendee> oldAttendeesMap = {
      for (var v in oldStudent.courseAttendees!) v.studentId!: v
    };
    // define which course attendees need to be created/deleted
    Set<String> newStudentsIds = newAttendeesMap.keys.toSet();
    Set<String> oldStudentsIds = oldAttendeesMap.keys.toSet();
    Set<String> deleteStudentsIds = oldStudentsIds.difference(newStudentsIds);
    Set<String> createStudentsIds = newStudentsIds.difference(oldStudentsIds);
    // create/delete courses attendees
    if (deleteStudentsIds.isNotEmpty) {
      Set<String> attendeesIdsToDelete = {
        for (var attendee in oldAttendeesMap.values)
          if (deleteStudentsIds.contains(attendee.studentId)) attendee.id!
      };
      await _attendeeRepo.deleteRecordsByIds(attendeesIdsToDelete);
    }
    if (createStudentsIds.isNotEmpty) {
      List<CourseAttendee> attendeesToCreate = [
        for (var attendee in newAttendeesMap.values)
          if (createStudentsIds.contains(attendee.studentId)) attendee
      ];
      await _attendeeRepo.createRecords(attendeesToCreate);
    }
  }

// ----- QUERY: COURSES -----
  // query all courses related to the current teacher
  Future<List<Course>> queryAllCourses() async =>
      await _provider.queryCourses(filtersAllActiveCourses);

  // get filters: 1) related to the teacher 2) isActive = true
  List<QueryFilter> get filtersAllActiveCourses {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) throw Exception(errNotLoggedIn);
    return [TeacherIdQueryFilter(teacherId)];
  }

  Future<Course> queryCourseById(String id) async =>
      await _provider.queryCourseById(id);

// ----- QUERY: RELATED RECORDS -----
  // query courses_attendees records related to a course
  Future<List<CourseAttendee>> queryRelatedAttendees(String courseId) =>
      _attendeeRepo.queryCoursesAttendeesByCourseId(courseId);

// ----- FILTER RECORDS -----
  List<Course> filterCoursesByIds(List<Course> courses, Set<String> ids) {
    List<CObject> cObjects = _provider.filterCObjectsByIds(courses, ids);
    List<Course> filteredCourses =
        cObjects.map((cObj) => cObj as Course).toList();
    return filteredCourses;
  }
}

/* not used
  Stream<Object?> queryCoursesStream() {
    String? teacherId = FirebaseAuthService.getUserIdIfLoggedIn();
    if (teacherId == null) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('courses')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots();
  }*/
