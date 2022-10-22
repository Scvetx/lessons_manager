import 'package:workbook/models/student.dart';
import 'students_list_wrap.dart';

abstract class StudentsListEvent {}

// --- state events: list layout ---
abstract class LayoutStudentsListEvent extends StudentsListEvent {
  final StudentsListWrap? listWrap;
  LayoutStudentsListEvent({required this.listWrap, bool? disableScreen});
}

class ReadyStudentsListEvent extends LayoutStudentsListEvent {
  ReadyStudentsListEvent({required StudentsListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorStudentsListEvent extends LayoutStudentsListEvent {
  final String errMsg;
  ErrorStudentsListEvent(
      {required StudentsListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}

// --- actions events: list layout ---
abstract class LayoutActionStudentsListEvent extends StudentsListEvent {}

class NewRecordStudentsListEvent extends LayoutActionStudentsListEvent {}

// --- actions events: list item ---
abstract class ItemStudentsListEvent extends StudentsListEvent {
  final Student student;
  ItemStudentsListEvent({required this.student});
}

class ViewRecordStudentsListEvent extends ItemStudentsListEvent {
  ViewRecordStudentsListEvent({required Student student})
      : super(student: student);
}

class EditRecordStudentsListEvent extends ItemStudentsListEvent {
  EditRecordStudentsListEvent({required Student student})
      : super(student: student);
}
