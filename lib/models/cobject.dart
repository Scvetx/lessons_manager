import 'package:workbook/extensions/string_ext.dart';

import 'package:workbook/constants/labels.dart';
import 'cfield.dart';

class ValidationException implements Exception {
  String msg;
  ValidationException(this.msg);
  @override
  String toString() => msg;
}

abstract class CObject {
// ----- STATIC -----
  static const String fNameLabel = 'Name';

  static const int fNameMaxLines = 1;

// ----- FIELDS -----
  String? id; // object id in db
  final TextCField name = TextCField(
      label: CObject.fNameLabel,
      value: '',
      maxNumberOfLines: fNameMaxLines); // object name in db

// ----- CONSTRUCTORS -----
  CObject();
  CObject.initEmpty({int? nameLength}) {
    name.maxLength = nameLength;
  }
  CObject.fromValues({this.id, required String name, int? nameLength}) {
    this.name.value = name;
    this.name.maxLength = nameLength;
  }

// ----- DB METHODS -----
  // convert obj to database map
  Map<String, dynamic> toMap() => {'name': name.value};

// ----- FORM METHODS -----
  // a map of Text fields for Text Inputs on forms
  Map<String, TextCField> getFormTextFieldsMap() => {'name': name};

  // set values entered on the form to the cObj fields
  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    name.value = fieldsMap['name']!.value;
  }

// ----- COPY OBJECT METHOD -----
  // copy current cObj as a new Instance of CObject
  void copy() {}

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
