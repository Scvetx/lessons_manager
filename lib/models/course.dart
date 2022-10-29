import 'cobject.dart';

class Course extends CObject {
  // --- STATIC ---
  static const String label = 'Course';
  static const String labelPlural = 'Courses';

  static const int fNameLength = 50;

  // --- VARIABLES ---
  final String teacherId; // teacher's User id

  // --- CONSTRUCTORS ---
  Course({required this.teacherId}) : super.initEmpty(nameLength: fNameLength);

  Course.fromMap(Map<String, dynamic> objMap) // parse db map to Course obj
      : teacherId = objMap['teacherId'],
        super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength);

  // --- METHODS ---
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'teacherId': teacherId,
    });
    return map;
  }
}
