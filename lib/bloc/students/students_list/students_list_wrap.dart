import 'package:workbook/models/student.dart';

class StudentsListWrap {
  final bool isRelatedList;
  final List<Student> students;
  StudentsListWrap({required this.students, required this.isRelatedList});
}
