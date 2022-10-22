import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/courses/course_repository.dart';

import 'package:workbook/models/course.dart';
import 'package:workbook/ui/screens/courses/courses_screen.dart';
import 'course_form_event.dart';
import 'course_form_state.dart';
import 'course_form_wrap.dart';

class CourseFormBloc extends Bloc<CourseFormEvent, CourseFormState> {
  final CourseRepository _repository = CourseRepository();

  CourseFormBloc({required Course? course}) : super(LoadingCourseFormState()) {
    on<ReadyCourseFormEvent>((event, emit) => _onReady(event));
    on<SaveCourseFormEvent>((event, emit) => _onSave(event));
    on<SavingCourseFormEvent>((event, emit) => _onSaving(event));
    on<ErrorCourseFormEvent>((event, emit) => _onError(event));

    init(course);
  }

// - ADD EVENTS -
  void init(Course? course) {
    try {
      CourseFormWrap formWrap = CourseFormWrap(course: course);
      add(ReadyCourseFormEvent(formWrap: formWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSave() {
    try {
      state.formWrap!.prepareToSave();
      add(SaveCourseFormEvent(formWrap: state.formWrap!));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSaving() async {
    try {
      await _repository.upsertRecord(
          state.formWrap!.isNew, state.formWrap!.course);
      NavigationService.clearRouteAndPushNamed(CoursesScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    debugPrint(errMsg);
    add(ErrorCourseFormEvent(formWrap: state.formWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyCourseFormEvent event) {
    ReadyCourseFormState state =
        ReadyCourseFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSave(SaveCourseFormEvent event) {
    SaveCourseFormState state = SaveCourseFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSaving(SavingCourseFormEvent event) {
    SavingCourseFormState state =
        SavingCourseFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onError(ErrorCourseFormEvent event) {
    ErrorCourseFormState state =
        ErrorCourseFormState(formWrap: event.formWrap, errMsg: event.errMsg);
    _setState(state);
  }

  void _setState(CourseFormState state) {
    emit(state);
  }
}
