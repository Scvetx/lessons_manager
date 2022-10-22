import 'package:workbook/bloc/lessons/lesson_view/lesson_view_wrap.dart';

abstract class LessonViewEvent {
  final LessonViewWrap? viewWrap;
  LessonViewEvent({required this.viewWrap});
}

class ReadyLessonViewEvent extends LessonViewEvent {
  ReadyLessonViewEvent({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteLessonViewEvent extends LessonViewEvent {
  DeleteLessonViewEvent({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeletingLessonViewEvent extends LessonViewEvent {
  DeletingLessonViewEvent({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class ErrorLessonViewEvent extends LessonViewEvent {
  final String errMsg;
  ErrorLessonViewEvent(
      {required LessonViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
