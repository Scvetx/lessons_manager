import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/cfield.dart';
import 'package:workbook/models/course.dart';

class CourseFormWrap {
  bool isNew = false;
  late Course? oldCourse;
  late Course course;
  late Map<String, TextCField> fieldsMap;

  CourseFormWrap({Course? course}) {
    if (course == null) {
      // user is creating record
      isNew = true;
      String teacherId = FirebaseAuthService.getUserIdIfLoggedIn() ?? '';
      this.course = Course.create(teacherId: teacherId);
    } else {
      // user is editing record
      oldCourse = course.copy();
      this.course = course;
    }
    _getFormTextFields();
  }
  void prepareToSave() {
    course.validateFields();
    _setFormTextFields();
  }

  // get current fields values
  void _getFormTextFields() => fieldsMap = course.getFormTextFieldsMap();
  // set values entered in the form
  void _setFormTextFields() => course.setFormTextFields(fieldsMap);
}
