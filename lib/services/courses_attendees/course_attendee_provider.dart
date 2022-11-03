/* functions dml/query courses_attendees
*/

import 'package:workbook/services/app/firebase/firebase_collection.dart';
import 'package:workbook/services/app/firebase/query_filter.dart';
import 'package:workbook/models/course_attendee.dart';

class CourseAttendeeProvider extends FirebaseCollection {
  CourseAttendeeProvider() : super(collectionName: 'courses_attendees');
// -- QUERY RECORDS --
  // query courses_attendees by filters
  Future<List<CourseAttendee>> queryCoursesAttendees(
      List<QueryFilter> filters) async {
    List<CourseAttendee> records = [];
    var docs = await queryRecords(filters);
    for (var doc in docs) {
      Map<String, dynamic> objMap = doc.data() as Map<String, dynamic>;
      CourseAttendee rec = CourseAttendee.fromMap(objMap);
      rec.id = doc.id;
      records.add(rec);
    }
    return records;
  }
}
