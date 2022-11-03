import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/lessons/lesson_repository.dart';

import 'package:workbook/models/lesson.dart';
import 'package:workbook/ui/screens/lessons/lessons_screen.dart';
import 'lesson_form_event.dart';
import 'lesson_form_state.dart';
import 'lesson_form_wrap.dart';

class LessonFormBloc extends Bloc<LessonFormEvent, LessonFormState> {
  final LessonRepository _repository = LessonRepository();

  LessonFormBloc({required Lesson? lesson}) : super(LoadingLessonFormState()) {
    on<ReadyLessonFormEvent>((event, emit) => _onReady(event));
    on<SaveLessonFormEvent>((event, emit) => _onSave(event));
    on<SavingLessonFormEvent>((event, emit) => _onSaving(event));
    on<ErrorLessonFormEvent>((event, emit) => _onError(event));

    init(lesson);
  }

// - ADD EVENTS -
  void init(Lesson? lesson) {
    try {
      LessonFormWrap formWrap = LessonFormWrap(lesson: lesson);
      add(ReadyLessonFormEvent(formWrap: formWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSave() {
    try {
      state.formWrap!.prepareToSave();
      add(SaveLessonFormEvent(formWrap: state.formWrap!));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSaving() async {
    try {
      if (state.formWrap!.isNew) {
        await _repository.createRecord(state.formWrap!.lesson);
      } else {
        await _repository.updateRecord(state.formWrap!.lesson);
      }
      NavigationService.clearRouteAndPushNamed(LessonsScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    debugPrint(errMsg);
    add(ErrorLessonFormEvent(formWrap: state.formWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyLessonFormEvent event) {
    ReadyLessonFormState state =
        ReadyLessonFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSave(SaveLessonFormEvent event) {
    SaveLessonFormState state = SaveLessonFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSaving(SavingLessonFormEvent event) {
    SavingLessonFormState state =
        SavingLessonFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onError(ErrorLessonFormEvent event) {
    ErrorLessonFormState state =
        ErrorLessonFormState(formWrap: event.formWrap, errMsg: event.errMsg);
    _setState(state);
  }

  void _setState(LessonFormState state) {
    emit(state);
  }
}
