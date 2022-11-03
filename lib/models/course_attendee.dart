import 'cobject.dart';

// a junction object between courses and students
class CourseAttendee extends CObject {
// ----- FIELDS -----
  late String studentId;
  late String courseId;

// ----- CONSTRUCTORS -----
  CourseAttendee({required this.studentId, required this.courseId});

  // parse db map to Course Attendee obj
  CourseAttendee.fromMap(Map<String, dynamic> objMap)
      : studentId = objMap['studentId'] ?? '',
        courseId = objMap['courseId'] ?? '';

// ----- DB METHODS -----
  // convert CourseAttendee to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({'studentId': studentId, 'courseId': courseId});
    return map;
  }
}
