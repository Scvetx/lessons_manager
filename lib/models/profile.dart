import 'package:firebase_auth/firebase_auth.dart';
import 'package:workbook/extensions/string_ext.dart';
import 'cfield.dart';
import 'cobject.dart';
import 'package:workbook/constants/labels.dart';

class ProfileValidationException implements Exception {
  String msg;
  ProfileValidationException(this.msg);
  @override
  String toString() => msg;
}

class Profile extends CObject {
  // --- STATIC ---
  static const String label = 'Profile';
  static const String fEmailLabel = 'Email';
  static const String fPasswordLabel = 'Password';
  static const String fPhotoLabel = 'Photo';

  static const int fNameLength = 100;
  static const int fEmailLength = 300;

  // --- FIELDS ---
  String photoURL = ''; // user's photo URL

  TextCField email = TextCField(
      label: fEmailLabel, value: '', maxLength: fEmailLength); // user's email

  // --- CONSTRUCTORS ---
  Profile() : super.initEmpty(nameLength: fNameLength);

  Profile.fromUser(User user) // parse User obj to Profile obj
      : super.fromValues(
            name: user.displayName ?? '', nameLength: fNameLength) {
    photoURL = user.photoURL ?? '';
    email.value = user.email ?? '';
  }

  Profile.fromMap(Map<String, dynamic> objMap) // parse db map to Profile obj
      : super.fromValues(name: objMap['name'] ?? '', nameLength: fNameLength) {
    photoURL = objMap['photoURL'] ?? '';
    email.value = objMap['email'] ?? '';
  }

  // --- METHODS ---
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'photoURL': photoURL,
      'email': email.value,
    });
    return map;
  }

  @override
  Map<String, TextCField> getFormTextFieldsMap() {
    Map<String, TextCField> map = super.getFormTextFieldsMap();
    map.addAll({
      'email': email,
    });
    return map;
  }

  @override
  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    super.setFormTextFields(fieldsMap);
    email = fieldsMap['email']!;
  }

  void validateName() {
    if (name.value.isBlank) {
      throw ProfileValidationException(
          '${CObject.fNameLabel} $errFieldNotEntered');
    }
  }

  void validateEmail(String? password) {
    if (email.value.isBlank || password.isBlank) {
      throw ProfileValidationException('$fEmailLabel $errFieldNotEntered');
    }
  }
}
