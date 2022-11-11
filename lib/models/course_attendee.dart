import 'dbobject.dart';

// a junction object between courses and students
class CourseAttendee extends DBObject {
// ----- FIELDS -----
  late String studentId;
  late String courseId;

// ----- CONSTRUCTORS -----
  CourseAttendee.create({required this.studentId, required this.courseId})
      : super.create();

  // parse db map to Course Attendee obj
  CourseAttendee.fromMap(Map<String, dynamic> objMap)
      : studentId = objMap['studentId'] ?? '',
        courseId = objMap['courseId'] ?? '',
        super.fromMap(objMap);

// ----- DB METHODS -----
  // convert CourseAttendee to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({'studentId': studentId, 'courseId': courseId});
    return map;
  }
}
