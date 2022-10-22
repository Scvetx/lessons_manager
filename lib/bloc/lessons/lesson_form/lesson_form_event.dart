import 'package:workbook/bloc/lessons/lesson_form/lesson_form_wrap.dart';

abstract class LessonFormEvent {
  final LessonFormWrap? formWrap;
  LessonFormEvent({required this.formWrap});
}

class ReadyLessonFormEvent extends LessonFormEvent {
  ReadyLessonFormEvent({required LessonFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveLessonFormEvent extends LessonFormEvent {
  SaveLessonFormEvent({required LessonFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SavingLessonFormEvent extends LessonFormEvent {
  SavingLessonFormEvent({required LessonFormWrap formWrap})
      : super(formWrap: formWrap);
}

class ErrorLessonFormEvent extends LessonFormEvent {
  final String errMsg;
  ErrorLessonFormEvent(
      {required LessonFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
