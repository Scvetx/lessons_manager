/* functions to process dml/queried courses_attendees
*/

import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/services/courses_attendees/course_attendee_provider.dart';
import 'package:workbook/models/course_attendee.dart';

class CourseAttendeeRepository {
  final CourseAttendeeProvider _provider = CourseAttendeeProvider();

// ----- DML: COURSE ATTENDEE -----
  // create 1 course attendee
  Future createRecord(Map<String, dynamic> fieldsMap) async =>
      await _provider.createRecord(fieldsMap);
  // delete 1 course attendee
  Future deleteRecord(CourseAttendee courseAttendee) async =>
      await _provider.deleteRecord(courseAttendee.id!);

// ----- BULK DML: COURSES ATTENDEES -----
  // bulk create
  Future createRecords(List<CourseAttendee> coursesAttendees) async =>
      await _provider.createRecords(coursesAttendees);
  // bulk update
  Future updateRecords(List<CourseAttendee> coursesAttendees) async =>
      await _provider.updateRecords(coursesAttendees);
  // bulk delete by records ids
  Future deleteRecordsByIds(Set<String> ids) async =>
      await _provider.deleteRecordsByIds(ids);

// ----- QUERY: COURSES ATTENDEES -----
  // query <courses_attendees> records related to a student
  Future<List<CourseAttendee>> queryCoursesAttendeesByStudentId(
      String studentId) async {
    List<QueryFilter> filters = [StudentIdQueryFilter(studentId)];
    return await _provider.queryCoursesAttendees(filters);
  }

  // query <courses_attendees> records related to a course
  Future<List<CourseAttendee>> queryCoursesAttendeesByCourseId(
      String courseId) async {
    List<QueryFilter> filters = [CourseIdQueryFilter(courseId)];
    return await _provider.queryCoursesAttendees(filters);
  }
}
