import 'package:workbook/bloc/courses/course_view/course_view_wrap.dart';

abstract class CourseViewEvent {
  final CourseViewWrap? viewWrap;
  CourseViewEvent({required this.viewWrap});
}

class ReadyCourseViewEvent extends CourseViewEvent {
  ReadyCourseViewEvent({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeleteCourseViewEvent extends CourseViewEvent {
  DeleteCourseViewEvent({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class DeletingCourseViewEvent extends CourseViewEvent {
  DeletingCourseViewEvent({required CourseViewWrap viewWrap})
      : super(viewWrap: viewWrap);
}

class ErrorCourseViewEvent extends CourseViewEvent {
  final String errMsg;
  ErrorCourseViewEvent(
      {required CourseViewWrap? viewWrap, required this.errMsg})
      : super(viewWrap: viewWrap);
}
