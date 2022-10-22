import 'package:workbook/bloc/app/screen_state.dart';
import 'package:workbook/bloc/courses/course_view/course_view_wrap.dart';

abstract class CourseViewState extends ScreenState {
  final CourseViewWrap? viewWrap;
  CourseViewState({this.viewWrap, bool? disableScreen})
      : super(disableScreen: disableScreen);
}

class LoadingCourseViewState extends CourseViewState {}

class ReadyCourseViewState extends CourseViewState {
  ReadyCourseViewState({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteCourseViewState extends CourseViewState {
  DeleteCourseViewState({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class DeletingCourseViewState extends CourseViewState {
  DeletingCourseViewState({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap, disableScreen: true);
}

class ErrorCourseViewState extends CourseViewState {
  final String errMsg;
  ErrorCourseViewState(
      {required CourseViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
