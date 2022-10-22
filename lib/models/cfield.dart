import 'package:workbook/models/language_level.dart';

// abstract class for records fields
abstract class CField {
  final String label;
  CField({required this.label});
}

// text field used on records forms
class TextCField extends CField {
  late String value;
  int? length;

  TextCField({required String label, required this.value, this.length})
      : super(label: label);
}

// text field used on records forms
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

class CoursesField extends CField {
  late List<String> values;

  CoursesField({required String label, required this.values})
      : super(label: label) {
    if (values.isNotEmpty) values.sort();
  }
}
