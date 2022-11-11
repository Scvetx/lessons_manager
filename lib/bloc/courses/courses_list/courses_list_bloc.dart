import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/courses/course_repository.dart';
import 'package:workbook/services/lessons/lesson_repository.dart';

import 'package:workbook/models/course.dart';
import 'package:workbook/ui/screens/courses/course_form_screen.dart';
import 'package:workbook/ui/screens/courses/course_view_screen.dart';
import 'courses_list_event.dart';
import 'courses_list_state.dart';
import 'courses_list_wrap.dart';

class CoursesListBloc extends Bloc<CoursesListEvent, CoursesListState> {
  final CourseRepository _repository = CourseRepository();
  final LessonRepository _lessonRepository = LessonRepository();

  CoursesListBloc() : super(LoadingCoursesListState()) {
    // --- state events: list layout ---
    on<ReadyCoursesListEvent>((event, emit) => _onReady(event));
    on<ErrorCoursesListEvent>((event, emit) => _onError(event));
    // --- actions events: list layout ---
    on<NewRecordCoursesListEvent>((event, emit) => _onNewRecord(event));
    // --- actions events: list item ---
    on<ViewRecordCoursesListEvent>((event, emit) => _onViewRecord(event));
    on<EditRecordCoursesListEvent>((event, emit) => _onEditRecord(event));

    init();
  }

// - ADD EVENTS -
// --- state events: list layout ---
  void init() async {
    try {
      List<Course> courses = await _repository.queryAllCourses();
      CoursesListWrap listWrap = CoursesListWrap(courses: courses);
      add(ReadyCoursesListEvent(listWrap: listWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorCoursesListEvent(listWrap: state.listWrap!, errMsg: errMsg));
  }

// --- actions events: list layout ---
  void toNewRecord() {
    add(NewRecordCoursesListEvent());
  }

// --- actions events: list item ---
  void toViewRecord(Course course) {
    add(ViewRecordCoursesListEvent(course: course));
  }

  void toEditRecord(Course course) {
    add(EditRecordCoursesListEvent(course: course));
  }

// - EVENT HANDLERS -
// --- state events: list layout ---
  void _onReady(ReadyCoursesListEvent event) {
    ReadyCoursesListState state =
        ReadyCoursesListState(listWrap: event.listWrap!);
    _setState(state);
  }

  void _onError(ErrorCoursesListEvent event) {
    ErrorCoursesListState state =
        ErrorCoursesListState(listWrap: event.listWrap!, errMsg: event.errMsg);
    _setState(state);
  }

// --- actions events: list layout ---
  void _onNewRecord(NewRecordCoursesListEvent event) {
    NavigationService.pushNamed(CourseFormScreen.id, null);
  }

// --- actions events: list item ---
  void _onViewRecord(ViewRecordCoursesListEvent event) async {
    // get courses attendees related to the course
    event.course.courseAttendees =
        await _repository.queryRelatedAttendees(event.course.id!);
    // get lessons related to the course
    event.course.lessons =
        await _lessonRepository.queryLessonsByCourseId(event.course.id!);
    NavigationService.pushNamed(CourseViewScreen.id, event.course);
  }

  void _onEditRecord(EditRecordCoursesListEvent event) async {
    // get courses attendees related to the course
    event.course.courseAttendees =
        await _repository.queryRelatedAttendees(event.course.id!);
    // get lessons related to the course
    event.course.lessons =
        await _lessonRepository.queryLessonsByCourseId(event.course.id!);
    NavigationService.pushNamed(CourseFormScreen.id, event.course);
  }

// --- set state ---
  void _setState(CoursesListState state) {
    emit(state);
  }
}
