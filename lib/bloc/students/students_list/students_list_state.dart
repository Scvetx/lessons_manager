import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/students/students_list/students_list_wrap.dart';

abstract class StudentsListState extends ScreenState {
  final StudentsListWrap? listWrap;
  StudentsListState({required this.listWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingStudentsListState extends StudentsListState {
  LoadingStudentsListState() : super(listWrap: null);
}

class ReadyStudentsListState extends StudentsListState {
  ReadyStudentsListState({required StudentsListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorStudentsListState extends StudentsListState {
  final String errMsg;
  ErrorStudentsListState(
      {required StudentsListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}
