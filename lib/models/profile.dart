import 'package:firebase_auth/firebase_auth.dart';
import 'package:workbook/extensions/string_ext.dart';
import 'cfield.dart';
import 'cobject.dart';
import 'package:workbook/constants/labels.dart';

class Profile extends CObject {
// ----- STATIC -----
  static const String label = 'Profile';
  static const String fEmailLabel = 'Email';
  static const String fPasswordLabel = 'Password';
  static const String fPhotoLabel = 'Photo';

  static const int fNameLength = 100;
  static const int fEmailLength = 300;

// ----- FIELDS -----
  String photoURL = ''; // user's photo URL

  TextCField email = TextCField(
      label: fEmailLabel, value: '', maxLength: fEmailLength); // user's email

// ----- CONSTRUCTORS -----
  // Profile obj with empty fields: used when creating a new User record
  Profile() : super.initEmpty(nameLength: fNameLength);

  // convert User obj to Profile obj
  Profile.fromUser(User user)
      : super.fromValues(
            name: user.displayName ?? '', nameLength: fNameLength) {
    photoURL = user.photoURL ?? '';
    email.value = user.email ?? '';
  }

  // parse db map to Profile obj
  Profile.fromMap(Map<String, dynamic> objMap)
      : super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength) {
    photoURL = objMap['photoURL'] ?? '';
    email.value = objMap['email'] ?? '';
  }

// ----- DB METHODS -----
  // convert Profile to db map
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'photoURL': photoURL,
      'email': email.value,
    });
    return map;
  }

// ----- FORM METHODS -----
  // get text fields which for Text inputs on the user's form
  @override
  Map<String, TextCField> getFormTextFieldsMap() {
    Map<String, TextCField> map = super.getFormTextFieldsMap();
    map.addAll({
      'email': email,
    });
    return map;
  }

  // set values entered on the form to the Profile fields
  @override
  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    super.setFormTextFields(fieldsMap);
    email = fieldsMap['email']!;
  }

// ----- VALIDATE FIELDS METHODS -----
  // validate entered Profile fields
  @override
  void validateFields() {
    super.validateFields();
    validateEmail();
  }

  void validateEmail() {
    if (email.value.isBlank) {
      throw ValidationException('$fEmailLabel $errFieldNotEntered');
    }
  }

  // check if email and password were entered correctly while editing email
  void validateEmailEdit(String? password) {
    validateEmail();
    if (password.isBlank) {
      throw ValidationException('$fPasswordLabel $errFieldNotEntered');
    }
  }
}
