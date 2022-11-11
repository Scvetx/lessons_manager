import 'cfield.dart';
import 'cobject.dart';
import 'profile.dart';
import 'course_attendee.dart';

class Student extends Profile {
// ----- STATIC -----
  static const String label = 'Student';
  static const String labelPlural = 'Students';
  static const String fLanguageLevelLabel = 'Level';
  static const String fGoalLabel = 'Goal';

// ----- FIELDS -----
  late String teacherId; // teacher user id (empty if teacher removed student)
  late String userId; // student's User id
  bool isActive = true; // if active then showed in the lists
  bool isVerified = false;

  String? firstLoginPassword; // tmp password generated for first login

  final LanguageLevelField languageLevel = LanguageLevelField(
      label: fLanguageLevelLabel, value: ''); // language level set by a teacher

  final LanguageLevelField goal = LanguageLevelField(
      label: fGoalLabel, value: ''); // studying goal (target language level)

// ----- RELATED RECORDS LIST -----
// ------- courses attendees-------
  // all Courses which the student attends
  // *query courses when need their data, for ex, before showing student_view_screen
  List<CourseAttendee>? courses;

  // ids of student's courses
  Set<String>? _coursesIds;
  Set<String> get coursesIds {
    if (_coursesIds == null) _initCoursesIds();
    return _coursesIds!;
  }

  void _initCoursesIds() =>
      _coursesIds = courses == null ? {} : {for (var v in courses!) v.courseId};

// ----- CONSTRUCTORS -----
  // creates an new Student with empty fields: used on student_form_screen
  Student.create({required this.teacherId}) : courses = [];

  // parse db map to Student obj
  Student.fromMap(Map<String, dynamic> objMap)
      : teacherId = objMap['teacherId'] ?? '',
        userId = objMap['userId'] ?? '',
        super.fromMap(objMap) {
    isActive = objMap['isActive'] ?? isActive;
    isVerified = objMap['isVerified'] ?? isVerified;
    languageLevel.value = objMap['languageLevel'] ?? '';
    goal.value = objMap['goal'] ?? '';
  }

// ----- DB METHODS -----
  // convert Student to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'isActive': isActive,
      'isVerified': isVerified,
      'teacherId': teacherId,
      'userId': userId,
      'languageLevel': languageLevel.value,
      'goal': goal.value
    });
    return map;
  }

// ----- COPY OBJECT METHOD -----
  // returns current Student obj copy as a new Instance of Student
  // used while updating Student to store the old value
  Student copy({String? name, bool? isActive, bool? isVerified}) {
    Map<String, dynamic> objMap = toMap();
    Student copy = Student.fromMap(objMap);
    copy.id = id;
    copy.courses = courses == null ? null : List.from(courses!);
    copy.name.value = name ?? this.name.value;
    copy.isActive = isActive ?? this.isActive;
    copy.isVerified = isVerified ?? this.isVerified;
    return copy;
  }

// ----- VALIDATE FIELDS METHODS -----
  // validate entered Student fields
  @override
  void validateFields() {
    super.validateFields();
    _validateLanguageLevelAndGoal();
  }

  // ensure that goal is greater than current language level
  void _validateLanguageLevelAndGoal() {
    if (goal.value.isEmpty || languageLevel.value.isEmpty) return;
    if (goal < languageLevel) {
      throw ValidationException('Language level can\'t be greater than goal');
    }
  }

// ----- FORM METHODS -----
  // get text fields for student's form if student has verified account then the form is empty
  @override
  Map<String, TextCField> getFormTextFieldsMap() =>
      isVerified ? {} : super.getFormTextFieldsMap();

// ----- RELATED RECORDS METHODS -----
  // check if the student attends a course
  bool containsCourse(String courseId) => coursesIds.contains(courseId);

  // add course to the student
  void addCourse(String courseId) {
    courses ??= [];
    courses!
        .add(CourseAttendee.create(studentId: id ?? '', courseId: courseId));
    _initCoursesIds();
  }

  // remove course from the student
  void removeCourse(String courseId) {
    if (courses == null) return;
    courses!
        .removeWhere((courseAttendee) => courseAttendee.courseId == courseId);
    _initCoursesIds();
  }
}
