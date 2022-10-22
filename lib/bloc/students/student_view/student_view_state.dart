import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/students/student_view/student_view_wrap.dart';

abstract class StudentViewState extends ScreenState {
  final StudentViewWrap? viewWrap;
  StudentViewState({this.viewWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingStudentViewState extends StudentViewState {}

class ReadyStudentViewState extends StudentViewState {
  ReadyStudentViewState({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteStudentViewState extends StudentViewState {
  DeleteStudentViewState({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class DeletingStudentViewState extends StudentViewState {
  DeletingStudentViewState({required StudentViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class ErrorStudentViewState extends StudentViewState {
  final String errMsg;
  ErrorStudentViewState(
      {required StudentViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
