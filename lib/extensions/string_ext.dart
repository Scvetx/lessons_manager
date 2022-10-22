extension StringExt on String {
  String removeWhiteSpaces() => replaceAll(' ', '');

  bool get isBlank => removeWhiteSpaces() == '';
  bool get isNotBlank => !isBlank;
}

extension StringNullableExt on String? {
  bool get isBlank => this == null || this!.isBlank;
  bool get isNotBlank => !isBlank;
}
