import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/courses/course_form/course_form_wrap.dart';

abstract class CourseFormState extends ScreenState {
  final CourseFormWrap? formWrap;
  CourseFormState({this.formWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingCourseFormState extends CourseFormState {}

class ReadyCourseFormState extends CourseFormState {
  ReadyCourseFormState({required CourseFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveCourseFormState extends CourseFormState {
  SaveCourseFormState({required CourseFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class SavingCourseFormState extends CourseFormState {
  SavingCourseFormState({required CourseFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class ErrorCourseFormState extends CourseFormState {
  final String errMsg;
  ErrorCourseFormState(
      {required CourseFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
