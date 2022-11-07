import 'cfield.dart';
import 'cobject.dart';
import 'course.dart';

class Lesson extends CObject {
// ----- STATIC -----
  static const String label = 'Lesson';
  static const String labelPlural = 'Lessons';
  static const String fLanguageLevelLabel = 'Level';
  static const String fDescriptionLabel = 'Description';

  static const int fNameLength = 100;
  static const int fDescriptionLength = 250;

// ----- FIELDS -----
  final String teacherId; // teacher's User id
  String courseId = ''; // a course to which this lesson is added

  late TextCField description = TextCField(
      label: fDescriptionLabel,
      value: '',
      maxLength: fDescriptionLength); // lesson description

  late LanguageLevelField languageLevel = LanguageLevelField(
      label: fLanguageLevelLabel, value: ''); // lesson language level

// ----- PARENT RECORDS -----
// ------- parent course -------
  // *query course when data needed for ex, on view_lesson_screen
  Course? course;

// ----- CONSTRUCTORS -----
  // creates a new Lesson with empty fields: used on lesson_form_screen
  Lesson({required this.teacherId}) : super.initEmpty(nameLength: fNameLength);

  // parse db map to Lesson obj
  Lesson.fromMap(Map<String, dynamic> objMap)
      : teacherId = objMap['teacherId'] ?? '',
        courseId = objMap['courseId'] ?? '',
        super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength) {
    description.value = objMap['description'] ?? '';
    languageLevel.value = objMap['languageLevel'] ?? '';
  }

// ----- DB METHODS -----
  // convert Lesson to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'teacherId': teacherId,
      'courseId': courseId,
      'description': description.value,
      'languageLevel': languageLevel.value,
    });
    return map;
  }

// ----- COPY OBJECT METHOD -----
  // returns current Lesson obj copy as a new Instance of Lesson
  // used while updating Lesson to store the old value
  @override
  Lesson copy({String? name}) {
    Map<String, dynamic> objMap = toMap();
    Lesson copy = Lesson.fromMap(objMap);
    copy.id = id;
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
    description = fieldsMap['description']!;
  }
}
