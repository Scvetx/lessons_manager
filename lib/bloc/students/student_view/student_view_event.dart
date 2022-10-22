import 'package:workbook/bloc/students/student_view/student_view_wrap.dart';

abstract class StudentViewEvent {
  final StudentViewWrap? viewWrap;
  StudentViewEvent({this.viewWrap});
}

class ReadyStudentViewEvent extends StudentViewEvent {
  ReadyStudentViewEvent({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteStudentViewEvent extends StudentViewEvent {
  DeleteStudentViewEvent({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeletingStudentViewEvent extends StudentViewEvent {
  DeletingStudentViewEvent({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class ErrorStudentViewEvent extends StudentViewEvent {
  final String errMsg;
  ErrorStudentViewEvent(
      {required StudentViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
