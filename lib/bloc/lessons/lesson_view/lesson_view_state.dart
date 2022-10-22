import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_wrap.dart';

abstract class LessonViewState extends ScreenState {
  final LessonViewWrap? viewWrap;
  LessonViewState({this.viewWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingLessonViewState extends LessonViewState {}

class ReadyLessonViewState extends LessonViewState {
  ReadyLessonViewState({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteLessonViewState extends LessonViewState {
  DeleteLessonViewState({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class DeletingLessonViewState extends LessonViewState {
  DeletingLessonViewState({required LessonViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class ErrorLessonViewState extends LessonViewState {
  final String errMsg;
  ErrorLessonViewState(
      {required LessonViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
