import 'cfield.dart';

abstract class CObject {
  // --- STATIC ---
  static const String fNameLabel = 'Name';

  // --- VARIABLES ---
  String? id; // obj id in database
  late TextCField name = TextCField(
      // obj name
      label: CObject.fNameLabel,
      value: '');

  // --- CONSTRUCTORS ---
  CObject();
  CObject.initEmpty({int? nameLength}) {
    name.length = nameLength;
  }
  CObject.fromValues({this.id, required String name, int? nameLength}) {
    this.name.value = name;
    this.name.length = nameLength;
  }

  // --- METHODS ---
  Map<String, dynamic> toMap() {
    // convert obj to database map
    Map<String, dynamic> map = {'name': name.value};
    return map;
  }

  Map<String, TextCField> getFormTextFieldsMap() {
    // a map of fields available on a form
    return {
      'name': name,
    };
  }

  void setFormTextFields(Map<String, TextCField> fieldsMap) {
    // set values from a form to obj fields
    name = fieldsMap['name']!;
  }

  void validateFields() {}
}
