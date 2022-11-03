import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/cfield.dart';
import 'package:workbook/models/lesson.dart';

class LessonFormWrap {
  bool isNew = false;
  late Lesson? oldLesson;
  late Lesson lesson;
  late Map<String, TextCField> fieldsMap;

  LessonFormWrap({Lesson? lesson}) {
    if (lesson == null) {
      // user is creating record
      isNew = true;
      String teacherId = FirebaseAuthService.getUserIdIfLoggedIn() ?? '';
      this.lesson = Lesson(teacherId: teacherId);
    } else {
      // user is editing record
      oldLesson = lesson.copy();
      this.lesson = lesson;
    }
    _getFormTextFields();
  }
  void prepareToSave() {
    _setFormTextFields();
  }

  // get current fields values
  void _getFormTextFields() => fieldsMap = lesson.getFormTextFieldsMap();
  // set values entered in the form
  void _setFormTextFields() => lesson.setFormTextFields(fieldsMap);
}
