import 'cfield.dart';
import 'cobject.dart';

class Lesson extends CObject {
  // --- STATIC ---
  static const String label = 'Lesson';
  static const String labelPlural = 'Lessons';
  static const String fLanguageLevelLabel = 'Level';
  static const String fCoursesNamesLabel = 'Courses';

  static const int fNameLength = 100;

  // --- VARIABLES ---
  final String teacherId; // teacher's User id

  // student's language level
  late LanguageLevelField languageLevel =
      LanguageLevelField(label: fLanguageLevelLabel, value: '');

  // courses to which the lesson belongs
  late CoursesField coursesNames =
      CoursesField(label: fCoursesNamesLabel, values: []);

  // --- CONSTRUCTORS ---
  Lesson({required this.teacherId});
  Lesson.fromMap(Map<String, dynamic> objMap) // parse db map to Lesson obj
      : teacherId = objMap['teacherId'] ?? '',
        super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength) {
    languageLevel.value = objMap['languageLevel'] ?? '';
    coursesNames.values = objMap['coursesNames'] == null
        ? []
        : List<String>.from(objMap['coursesNames']);
  }
  // --- METHODS ---
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'teacherId': teacherId,
      'languageLevel': languageLevel.value,
      'coursesNames': coursesNames.values,
    });
    return map;
  }
}
