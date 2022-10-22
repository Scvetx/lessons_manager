import 'package:workbook/bloc/students/student_form/student_form_wrap.dart';

abstract class StudentFormEvent {
  final StudentFormWrap? formWrap;
  StudentFormEvent({required this.formWrap});
}

class ReadyStudentFormEvent extends StudentFormEvent {
  ReadyStudentFormEvent({required StudentFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SaveStudentFormEvent extends StudentFormEvent {
  SaveStudentFormEvent({required StudentFormWrap formWrap})
      : super(formWrap: formWrap);
}

class SavingStudentFormEvent extends StudentFormEvent {
  SavingStudentFormEvent({required StudentFormWrap formWrap})
      : super(formWrap: formWrap);
}

class ErrorStudentFormEvent extends StudentFormEvent {
  final String errMsg;
  ErrorStudentFormEvent(
      {required StudentFormWrap? formWrap, required this.errMsg})
      : super(formWrap: formWrap);
}
