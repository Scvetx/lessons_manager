import 'package:workbook/models/lesson.dart';

class LessonsListWrap {
  final bool relatedList;
  final List<Lesson> lessons;
  LessonsListWrap({required this.lessons, required this.relatedList});
}
