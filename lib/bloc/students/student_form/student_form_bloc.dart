import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/students/student_repository.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';
import 'student_form_event.dart';
import 'student_form_state.dart';
import 'student_form_wrap.dart';

class StudentFormBloc extends Bloc<StudentFormEvent, StudentFormState> {
  final StudentRepository _repository = StudentRepository();

  StudentFormBloc({required Student? student})
      : super(LoadingStudentFormState()) {
    on<ReadyStudentFormEvent>((event, emit) => _onReady(event));
    on<SaveStudentFormEvent>((event, emit) => _onSave(event));
    on<SavingStudentFormEvent>((event, emit) => _onSaving(event));
    on<ErrorStudentFormEvent>((event, emit) => _onError(event));

    init(student);
  }

// - ADD EVENTS -
  void init(Student? student) {
    try {
      StudentFormWrap formWrap = StudentFormWrap(student: student);
      add(ReadyStudentFormEvent(formWrap: formWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSave() {
    try {
      state.formWrap!.prepareToSave();
      add(SaveStudentFormEvent(formWrap: state.formWrap!));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toSaving() async {
    try {
      await _repository.upsertRecord(
          state.formWrap!.isNew, state.formWrap!.student);
      NavigationService.clearRouteAndPushNamed(StudentsScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    debugPrint(errMsg);
    add(ErrorStudentFormEvent(formWrap: state.formWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyStudentFormEvent event) {
    ReadyStudentFormState state =
        ReadyStudentFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSave(SaveStudentFormEvent event) {
    SaveStudentFormState state =
        SaveStudentFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onSaving(SavingStudentFormEvent event) {
    SavingStudentFormState state =
        SavingStudentFormState(formWrap: event.formWrap!);
    _setState(state);
  }

  void _onError(ErrorStudentFormEvent event) {
    ErrorStudentFormState state =
        ErrorStudentFormState(formWrap: event.formWrap, errMsg: event.errMsg);
    _setState(state);
  }

  void _setState(StudentFormState state) {
    emit(state);
  }
}
