import 'package:workbook/models/course.dart';
import 'courses_list_wrap.dart';

abstract class CoursesListEvent {}

// --- state events: list layout ---
abstract class LayoutCoursesListEvent extends CoursesListEvent {
  final CoursesListWrap? listWrap;
  LayoutCoursesListEvent({required this.listWrap, bool? disableScreen});
}

class ReadyCoursesListEvent extends LayoutCoursesListEvent {
  ReadyCoursesListEvent({required CoursesListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorCoursesListEvent extends LayoutCoursesListEvent {
  final String errMsg;
  ErrorCoursesListEvent(
      {required CoursesListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}

// --- actions events: list layout ---
abstract class LayoutActionCoursesListEvent extends CoursesListEvent {}

class NewRecordCoursesListEvent extends LayoutActionCoursesListEvent {}

// --- actions events: list item ---
abstract class ItemCoursesListEvent extends CoursesListEvent {
  final Course course;
  ItemCoursesListEvent({required this.course});
}

class ViewRecordCoursesListEvent extends ItemCoursesListEvent {
  ViewRecordCoursesListEvent({required Course course}) : super(course: course);
}

class EditRecordCoursesListEvent extends ItemCoursesListEvent {
  EditRecordCoursesListEvent({required Course course}) : super(course: course);
}
