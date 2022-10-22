import 'package:workbook/models/lesson.dart';
import 'lessons_list_wrap.dart';

abstract class LessonsListEvent {}

// --- state events: list layout ---
abstract class LayoutLessonsListEvent extends LessonsListEvent {
  final LessonsListWrap? listWrap;
  LayoutLessonsListEvent({required this.listWrap, bool? disableScreen});
}

class ReadyLessonsListEvent extends LayoutLessonsListEvent {
  ReadyLessonsListEvent({required LessonsListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorLessonsListEvent extends LayoutLessonsListEvent {
  final String errMsg;
  ErrorLessonsListEvent(
      {required LessonsListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}

// --- actions events: list layout ---
abstract class LayoutActionLessonsListEvent extends LessonsListEvent {}

class NewRecordLessonsListEvent extends LayoutActionLessonsListEvent {}

// --- actions events: list item ---
abstract class ItemLessonsListEvent extends LessonsListEvent {
  final Lesson lesson;
  ItemLessonsListEvent({required this.lesson});
}

class ViewRecordLessonsListEvent extends ItemLessonsListEvent {
  ViewRecordLessonsListEvent({required Lesson lesson}) : super(lesson: lesson);
}

class EditRecordLessonsListEvent extends ItemLessonsListEvent {
  EditRecordLessonsListEvent({required Lesson lesson}) : super(lesson: lesson);
}
