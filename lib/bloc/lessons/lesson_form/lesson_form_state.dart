import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_wrap.dart';

abstract class LessonFormState extends ScreenState {
  final LessonFormWrap? formWrap;
  LessonFormState({this.formWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingLessonFormState extends LessonFormState {}

class ReadyLessonFormState extends LessonFormState {
  ReadyLessonFormState({required LessonFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveLessonFormState extends LessonFormState {
  SaveLessonFormState({required LessonFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class SavingLessonFormState extends LessonFormState {
  SavingLessonFormState({required LessonFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class ErrorLessonFormState extends LessonFormState {
  final String errMsg;
  ErrorLessonFormState(
      {required LessonFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
