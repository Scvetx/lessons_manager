import 'package:flutter_test/flutter_test.dart';
import 'package:workbook/models/cfield.dart';

void main() {
  testTextFieldWithLength();
  testTextFieldNoLength();
  testLanguageLevelField();
}

void testTextFieldWithLength() {
  test('when TextCField with length :: maxLength != null', () {
    // -- prepare test data --
    String label = 'Test field';
    String value = 'Test value';
    int maxLength = 50;

    // -- do test actions --
    TextCField field =
        TextCField(label: label, value: value, maxLength: maxLength);

    // -- check values --
    expect(field.label, label);
    expect(field.value, value);
    expect(field.maxLength, maxLength);
  });
}

void testTextFieldNoLength() {
  test('when TextCField without length :: maxLength = null', () {
    // -- prepare test data --
    String label = 'Test field';
    String value = 'Test value';

    // -- do test actions --
    TextCField field = TextCField(label: label, value: value);

    // -- check values --
    expect(field.label, label);
    expect(field.value, value);
    expect(field.maxLength, null);
  });
}

void testLanguageLevelField() {
  test('test comparing language levels in LanguageLevelField', () {
    // -- prepare test data --
    String label = 'Test field';
    String a0 = 'A0';
    String a1 = 'A1';
    String a2 = 'A2';
    String b1 = 'B1';
    String c2 = 'C2';

    // -- do test actions --
    LanguageLevelField levelA0 = LanguageLevelField(label: label, value: a0);
    LanguageLevelField levelA1 = LanguageLevelField(label: label, value: a1);
    LanguageLevelField levelA2 = LanguageLevelField(label: label, value: a2);
    LanguageLevelField levelB1 = LanguageLevelField(label: label, value: b1);
    LanguageLevelField levelC2 = LanguageLevelField(label: label, value: c2);

    // -- check values --
    expect(levelA0 < levelA1, true);
    expect(levelA0 > levelA1, false);

    expect(levelA1 < levelA2, true);
    expect(levelA1 > levelA2, false);

    expect(levelA2 < levelB1, true);
    expect(levelA2 > levelB1, false);

    expect(levelA2 < levelB1, true);
    expect(levelA2 > levelB1, false);

    expect(levelB1 < levelC2, true);
    expect(levelB1 > levelC2, false);

    expect(levelA2 < levelC2, true);
    expect(levelA2 > levelC2, false);

    expect(levelA2 < levelA2, false);
    expect(levelA2 > levelA2, false);
  });
}
