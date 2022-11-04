import 'cfield.dart';
import 'cobject.dart';
import 'course_attendee.dart';
import 'lesson.dart';

class Course extends CObject {
// ----- STATIC -----
  static const String label = 'Course';
  static const String labelPlural = 'Courses';
  static const String fDescriptionLabel = 'Description';

  static const int fNameLength = 50;
  static const int fDescriptionLength = 250;

// ----- FIELDS -----
  final String teacherId; // teacher's User id
  final TextCField description = TextCField(
      label: fDescriptionLabel,
      value: '',
      maxLength: fDescriptionLength); // course description

// ----- RELATED RECORDS LIST -----
// ------- courses attendees-------
  // Course attendees are not being queried from db during initialization:
  // query courses attendees when need data, For ex, before showing course_view_screen
  List<CourseAttendee>? courseAttendees; // all students who attend the course

  // ids of students attending this course
  Set<String>? _studentsIds;
  Set<String> get studentsIds {
    if (_studentsIds == null) _initStudentsIds();
    return _studentsIds!;
  }

  void _initStudentsIds() => _studentsIds = courseAttendees == null
      ? {}
      : {for (var v in courseAttendees!) v.studentId};

// ------- lessons -------
  List<Lesson>? lessons; // all students who attend the course

  // ids of students attending this course
  Set<String>? _lessonsIds;
  Set<String> get lessonsIds {
    if (_lessonsIds == null) _initLessonsIds();
    return _lessonsIds!;
  }

  void _initLessonsIds() =>
      _lessonsIds = lessons == null ? {} : {for (var v in lessons!) v.id!};

// ----- CONSTRUCTORS -----
  // creates a new Course with empty fields: used on course_form_screen
  Course.create({required this.teacherId})
      : courseAttendees = [],
        super.initEmpty(nameLength: fNameLength);

  // parse db map to Course obj
  Course.fromMap(Map<String, dynamic> objMap)
      : teacherId = objMap['teacherId'],
        super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength) {
    description.value = objMap['description'] ?? '';
  }

// ----- DB METHODS -----
  // convert Course to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'teacherId': teacherId,
      'description': description.value,
    });
    return map;
  }

// ----- COPY OBJECT METHOD -----
  // returns current Course obj copy as a new Instance of Course
  // used while updating Course to store the old value
  @override
  Course copy({String? name}) {
    Map<String, dynamic> objMap = toMap();
    Course copy = Course.fromMap(objMap);
    copy.id = id;
    copy.courseAttendees =
        courseAttendees == null ? null : List.from(courseAttendees!);
    copy.description.value = description.value;
    copy.name.value = name ?? this.name.value;
    return copy;
  }

// ----- FORM METHODS -----
  // get text fields which for Text inputs on the user's form
  @override
  Map<String, TextCField> getFormTextFieldsMap() {
    Map<String, TextCField> map = super.getFormTextFieldsMap();
    map.addAll({
      'description': description,
    });
    return map;
  }

  // set values entered on the form to the Profile fields
  @override
  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    super.setFormTextFields(fieldsMap);
    description.value = fieldsMap['description']!.value;
  }
}
