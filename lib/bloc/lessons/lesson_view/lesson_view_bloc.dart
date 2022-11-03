import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/lessons/lesson_repository.dart';

import 'package:workbook/models/lesson.dart';
import 'package:workbook/ui/screens/lessons/lessons_screen.dart';
import 'lesson_view_event.dart';
import 'lesson_view_state.dart';
import 'lesson_view_wrap.dart';

class LessonViewBloc extends Bloc<LessonViewEvent, LessonViewState> {
  final LessonRepository _repository = LessonRepository();

  LessonViewBloc({required Lesson lesson}) : super(LoadingLessonViewState()) {
    on<ReadyLessonViewEvent>((event, emit) => _onReady(event));
    on<DeleteLessonViewEvent>((event, emit) => _onDelete(event));
    on<DeletingLessonViewEvent>((event, emit) => _onDeleting(event));
    on<ErrorLessonViewEvent>((event, emit) => _onError(event));

    init(lesson);
  }

// - ADD EVENTS -
  void init(Lesson lesson) {
    try {
      LessonViewWrap viewWrap = LessonViewWrap(lesson: lesson);
      add(ReadyLessonViewEvent(viewWrap: viewWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toDelete() {
    add(DeleteLessonViewEvent(viewWrap: state.viewWrap!));
  }

  void toDeleting() async {
    try {
      await _repository.deleteRecord(state.viewWrap!.lesson);
      NavigationService.clearRouteAndPushNamed(LessonsScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorLessonViewEvent(viewWrap: state.viewWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyLessonViewEvent event) {
    ReadyLessonViewState viewState =
        ReadyLessonViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDelete(DeleteLessonViewEvent event) {
    DeleteLessonViewState viewState =
        DeleteLessonViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDeleting(DeletingLessonViewEvent event) {
    DeletingLessonViewState viewState =
        DeletingLessonViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onError(ErrorLessonViewEvent event) {
    ErrorLessonViewState viewState =
        ErrorLessonViewState(viewWrap: event.viewWrap, errMsg: event.errMsg);
    _setState(viewState);
  }

  void _setState(LessonViewState state) {
    emit(state);
  }
}
