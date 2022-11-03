import 'package:workbook/models/language_level.dart';

// abstract class for records fields
abstract class CField {
  final String label;
  CField({required this.label});
}

// text field used on records forms
class TextCField extends CField {
  String value;
  int? maxLength;

  TextCField({required String label, required this.value, this.maxLength})
      : super(label: label);
}

// LanguageLevel used on lessons, students
class LanguageLevelField extends CField {
  late LanguageLevel langLevel;

  String get value => langLevel.value;
  set value(String value) => langLevel.value = value;

  LanguageLevelField({required String label, required String value})
      : langLevel = LanguageLevel(value),
        super(label: label);

  bool operator >(LanguageLevelField other) => langLevel > other.langLevel;
  bool operator <(LanguageLevelField other) => langLevel < other.langLevel;
}
