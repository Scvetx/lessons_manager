import 'package:workbook/extensions/string_ext.dart';
import 'package:workbook/constants/labels.dart';
import 'cfield.dart';
import 'dbobject.dart';

class ValidationException implements Exception {
  String msg;
  ValidationException(this.msg);
  @override
  String toString() => msg;
}

abstract class CObject extends DBObject {
// ----- STATIC -----
  static const String fNameLabel = 'Name';

  static const int fNameMaxLines = 1;

  final TextCField name = TextCField(
      label: CObject.fNameLabel,
      value: '',
      maxNumberOfLines: fNameMaxLines); // object name in db

  CObject.create({int? nameLength}) : super.create() {
    name.maxLength = nameLength;
  }

  CObject.fromMap(Map<String, dynamic> objMap, {int? nameLength})
      : super.fromMap(objMap) {
    name.value = objMap['name'] ?? '';
    name.maxLength = nameLength;
  }

// ----- DB METHODS -----
  // convert obj to database map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({'name': name.value});
    return map;
  }

// ----- FORM METHODS -----
  // a map of Text fields for Text Inputs on forms
  Map<String, TextCField> getFormTextFieldsMap() => {'name': name};

  // set values entered on the form to the cObj fields
  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    name.value = fieldsMap['name']!.formattedValue;
  }

// ----- VALIDATE FIELDS METHOD -----
  // validate entered CObject fields
  void validateFields() {
    validateName();
  }

  // check if name was entered correctly
  void validateName() {
    if (name.value.isBlank) {
      throw ValidationException('${CObject.fNameLabel} $errFieldNotEntered');
    }
  }
}
