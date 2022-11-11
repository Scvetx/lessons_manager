import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/lessons/lesson_repository.dart';
import 'package:workbook/services/courses/course_repository.dart';

import 'package:workbook/models/lesson.dart';
import 'package:workbook/ui/screens/lessons/lesson_form_screen.dart';
import 'package:workbook/ui/screens/lessons/lesson_view_screen.dart';
import 'lessons_list_event.dart';
import 'lessons_list_state.dart';
import 'lessons_list_wrap.dart';

class LessonsListBloc extends Bloc<LessonsListEvent, LessonsListState> {
  final LessonRepository _repository = LessonRepository();
  final CourseRepository _courseRepository = CourseRepository();

  LessonsListBloc(Set<String>? lessonsIds) : super(LoadingLessonsListState()) {
    // --- state events: list layout ---
    on<ReadyLessonsListEvent>((event, emit) => _onReady(event));
    on<ErrorLessonsListEvent>((event, emit) => _onError(event));
    // --- actions events: list layout ---
    on<NewRecordLessonsListEvent>((event, emit) => _onNewRecord(event));
    // --- actions events: list item ---
    on<ViewRecordLessonsListEvent>((event, emit) => _onViewRecord(event));
    on<EditRecordLessonsListEvent>((event, emit) => _onEditRecord(event));

    init(lessonsIds);
  }

// - ADD EVENTS -
// --- state events: list layout ---
  void init(Set<String>? lessonsIds) async {
    try {
      List<Lesson> allLessons = await _repository.queryAllLessons();
      List<Lesson> lessons = lessonsIds == null
          ? allLessons
          : _repository.filterLessonsByIds(allLessons, lessonsIds!);
      LessonsListWrap listWrap =
          LessonsListWrap(lessons: lessons, relatedList: lessonsIds != null);
      add(ReadyLessonsListEvent(listWrap: listWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorLessonsListEvent(listWrap: state.listWrap!, errMsg: errMsg));
  }

// --- actions events: list layout ---
  void toNewRecord() {
    add(NewRecordLessonsListEvent());
  }

// --- actions events: list item ---
  void toViewRecord(Lesson lesson) {
    add(ViewRecordLessonsListEvent(lesson: lesson));
  }

  void toEditRecord(Lesson lesson) {
    add(EditRecordLessonsListEvent(lesson: lesson));
  }

// - EVENT HANDLERS -
// --- state events: list layout ---
  void _onReady(ReadyLessonsListEvent event) {
    ReadyLessonsListState state =
        ReadyLessonsListState(listWrap: event.listWrap!);
    _setState(state);
  }

  void _onError(ErrorLessonsListEvent event) {
    ErrorLessonsListState state =
        ErrorLessonsListState(listWrap: event.listWrap!, errMsg: event.errMsg);
    _setState(state);
  }

// --- actions events: list layout ---
  void _onNewRecord(NewRecordLessonsListEvent event) {
    NavigationService.pushNamed(LessonFormScreen.id, null);
  }

// --- actions events: list item ---
  void _onViewRecord(ViewRecordLessonsListEvent event) async {
    // get parent course
    if (event.lesson.courseId.isNotEmpty) {
      event.lesson.course =
          await _courseRepository.queryCourseById(event.lesson.courseId);
    }
    NavigationService.pushNamed(LessonViewScreen.id, event.lesson);
  }

  void _onEditRecord(EditRecordLessonsListEvent event) {
    NavigationService.pushNamed(LessonFormScreen.id, event.lesson);
  }

// --- set state ---
  void _setState(LessonsListState state) {
    emit(state);
  }
}
