import 'cfield.dart';
import 'profile.dart';

class StudentValidationException implements Exception {
  String msg;
  StudentValidationException(this.msg);
  @override
  String toString() => msg;
}

class Student extends Profile {
  // --- STATIC ---
  static const String label = 'Student';
  static const String labelPlural = 'Students';
  static const String fLanguageLevelLabel = 'Level';
  static const String fGoalLabel = 'Goal';
  static const String fCoursesNamesLabel = 'Courses';

  // --- VARIABLES ---
  late String teacherId; // teacher user id (empty if teacher removed student)
  late String userId; // student's User id

  // language level set by a teacher
  final LanguageLevelField languageLevel =
      LanguageLevelField(label: fLanguageLevelLabel, value: '');

  // student's studying goal (target language level)
  final LanguageLevelField goal =
      LanguageLevelField(label: fGoalLabel, value: '');

  // Names of all Courses which the student is taking
  final CoursesField coursesNames =
      CoursesField(label: fCoursesNamesLabel, values: []);

  // --- CONSTRUCTORS ---
  Student({required this.teacherId});
  Student.fromMap(Map<String, dynamic> objMap) // parse db map to Student obj
      : teacherId = objMap['teacherId'] ?? '',
        userId = objMap['userId'] ?? '',
        super.fromMap(objMap) {
    languageLevel.value = objMap['languageLevel'] ?? '';
    goal.value = objMap['goal'] ?? '';
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
      'userId': userId,
      'languageLevel': languageLevel.value,
      'goal': goal.value,
      'coursesNames': coursesNames.values,
    });
    return map;
  }

  @override
  void validateFields() {
    _validateLanguageLevelAndGoal();
  }

  void _validateLanguageLevelAndGoal() {
    // var relation = goal.value.compareTo(languageLevel.value);
    if (goal < languageLevel) {
      throw StudentValidationException(
          'Language level can\'t be greater than goal');
    }
  }
}
