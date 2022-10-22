import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_wrap.dart';

abstract class CoursesListState extends ScreenState {
  final CoursesListWrap? listWrap;
  CoursesListState({required this.listWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingCoursesListState extends CoursesListState {
  LoadingCoursesListState() : super(listWrap: null);
}

class ReadyCoursesListState extends CoursesListState {
  ReadyCoursesListState({required CoursesListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorCoursesListState extends CoursesListState {
  final String errMsg;
  ErrorCoursesListState(
      {required CoursesListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}
