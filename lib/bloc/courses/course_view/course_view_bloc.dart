import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/courses/course_repository.dart';

import 'package:workbook/models/course.dart';
import 'package:workbook/ui/screens/courses/courses_screen.dart';
import 'course_view_event.dart';
import 'course_view_state.dart';
import 'course_view_wrap.dart';

class CourseViewBloc extends Bloc<CourseViewEvent, CourseViewState> {
  final CourseRepository _repository = CourseRepository();

  CourseViewBloc({required Course course}) : super(LoadingCourseViewState()) {
    on<ReadyCourseViewEvent>((event, emit) => _onReady(event));
    on<DeleteCourseViewEvent>((event, emit) => _onDelete(event));
    on<DeletingCourseViewEvent>((event, emit) => _onDeleting(event));
    on<ErrorCourseViewEvent>((event, emit) => _onError(event));

    init(course);
  }

// - ADD EVENTS -
  void init(Course course) {
    try {
      CourseViewWrap viewWrap = CourseViewWrap(course: course);
      add(ReadyCourseViewEvent(viewWrap: viewWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toDelete() {
    add(DeleteCourseViewEvent(viewWrap: state.viewWrap!));
  }

  void toDeleting() async {
    try {
      await _repository.deleteRecord(state.viewWrap!.course.id!);
      NavigationService.clearRouteAndPushNamed(CoursesScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorCourseViewEvent(viewWrap: state.viewWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyCourseViewEvent event) {
    ReadyCourseViewState viewState =
        ReadyCourseViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDelete(DeleteCourseViewEvent event) {
    DeleteCourseViewState viewState =
        DeleteCourseViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDeleting(DeletingCourseViewEvent event) {
    DeletingCourseViewState viewState =
        DeletingCourseViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onError(ErrorCourseViewEvent event) {
    ErrorCourseViewState viewState =
        ErrorCourseViewState(viewWrap: event.viewWrap, errMsg: event.errMsg);
    _setState(viewState);
  }

  void _setState(CourseViewState state) {
    emit(state);
  }
}
