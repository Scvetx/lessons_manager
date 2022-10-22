import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_wrap.dart';

abstract class LessonsListState extends ScreenState {
  final LessonsListWrap? listWrap;
  LessonsListState({required this.listWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingLessonsListState extends LessonsListState {
  LoadingLessonsListState() : super(listWrap: null);
}

class ReadyLessonsListState extends LessonsListState {
  ReadyLessonsListState({required LessonsListWrap listWrap})
      : super(listWrap: listWrap);
}

class ErrorLessonsListState extends LessonsListState {
  final String errMsg;
  ErrorLessonsListState(
      {required LessonsListWrap listWrap, required this.errMsg})
      : super(listWrap: listWrap);
}
