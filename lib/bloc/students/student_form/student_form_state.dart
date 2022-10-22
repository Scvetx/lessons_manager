import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/students/student_form/student_form_wrap.dart';

abstract class StudentFormState extends ScreenState {
  final StudentFormWrap? formWrap;
  StudentFormState({this.formWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingStudentFormState extends StudentFormState {}

class ReadyStudentFormState extends StudentFormState {
  ReadyStudentFormState({required StudentFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveStudentFormState extends StudentFormState {
  SaveStudentFormState({required StudentFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class SavingStudentFormState extends StudentFormState {
  SavingStudentFormState({required StudentFormWrap formWrap})
      : super(formWrap: formWrap, disableScreen: true);
}

class ErrorStudentFormState extends StudentFormState {
  final String errMsg;
  ErrorStudentFormState(
      {required StudentFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
