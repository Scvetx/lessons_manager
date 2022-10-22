import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/cfield.dart';
import 'package:workbook/models/student.dart';

class StudentFormWrap {
  bool isNew = false;
  late Student student;
  late Map<String, TextCField> fieldsMap;

  StudentFormWrap({Student? student}) {
    if (student == null) {
      // user is creating record
      isNew = true;
      String teacherId = FirebaseAuthService.getUserIdIfLoggedIn() ?? '';
      this.student = Student(teacherId: teacherId);
    } else {
      // user is editing record
      this.student = student;
    }
    _getFormTextFields();
  }
  void prepareToSave() {
    _setFormTextFields();
    student.validateFields();
  }

  // get current fields values
  void _getFormTextFields() => fieldsMap = student.getFormTextFieldsMap();
  // set values entered in the form
  void _setFormTextFields() => student.setFormTextFields(fieldsMap);
}
