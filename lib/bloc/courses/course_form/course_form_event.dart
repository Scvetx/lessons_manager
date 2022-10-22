import 'package:workbook/bloc/courses/course_form/course_form_wrap.dart';

abstract class CourseFormEvent {
  final CourseFormWrap? formWrap;
  CourseFormEvent({required this.formWrap});
}

class ReadyCourseFormEvent extends CourseFormEvent {
  ReadyCourseFormEvent({required CourseFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveCourseFormEvent extends CourseFormEvent {
  SaveCourseFormEvent({required CourseFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SavingCourseFormEvent extends CourseFormEvent {
  SavingCourseFormEvent({required CourseFormWrap formWrap})
      : super(formWrap: formWrap);
}

class ErrorCourseFormEvent extends CourseFormEvent {
  final String errMsg;
  ErrorCourseFormEvent(
      {required CourseFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
