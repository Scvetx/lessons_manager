/* Query filters wrapper classes for .where() Firebase db function
*/

enum StringQueryOperator { equal }

enum BoolQueryOperator { equal }

abstract class QueryFilter {
  final String field;
  QueryFilter({required this.field});
}

// ----- BOOLEAN FILTERS -----
class BoolQueryFilter extends QueryFilter {
  final bool value;
  final BoolQueryOperator operator;
  BoolQueryFilter(
      {required super.field, required this.value, required this.operator});
}

class IsActiveQueryFilter extends BoolQueryFilter {
  static const String fIsActive = 'isActive';
  IsActiveQueryFilter(bool value)
      : super(
            value: value, field: fIsActive, operator: BoolQueryOperator.equal);
}

// ----- ID FILTER -----
class IdQueryFilter extends QueryFilter {
  static const String fId = 'id';
  final String value;
  IdQueryFilter(this.value) : super(field: fId);
}

// ----- STRING FILTERS -----
class StringQueryFilter extends QueryFilter {
  final String value;
  final StringQueryOperator operator;
  StringQueryFilter(
      {required super.field, required this.value, required this.operator});
}

class TeacherIdQueryFilter extends StringQueryFilter {
  static const String fTeacherId = 'teacherId'; // current teacher user id
  TeacherIdQueryFilter(String value)
      : super(
            value: value,
            field: fTeacherId,
            operator: StringQueryOperator.equal);
}

class StudentIdQueryFilter extends StringQueryFilter {
  static const String fStudentId = 'studentId';
  StudentIdQueryFilter(String value)
      : super(
            value: value,
            field: fStudentId,
            operator: StringQueryOperator.equal);
}

class CourseIdQueryFilter extends StringQueryFilter {
  static const String fCourseId = 'courseId';
  CourseIdQueryFilter(String value)
      : super(
            value: value,
            field: fCourseId,
            operator: StringQueryOperator.equal);
}
