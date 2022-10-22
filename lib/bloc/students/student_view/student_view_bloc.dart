import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/students/student_repository.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';
import 'student_view_event.dart';
import 'student_view_state.dart';
import 'student_view_wrap.dart';

class StudentViewBloc extends Bloc<StudentViewEvent, StudentViewState> {
  final StudentRepository _repository = StudentRepository();

  StudentViewBloc({required Student student})
      : super(LoadingStudentViewState()) {
    on<ReadyStudentViewEvent>((event, emit) => _onReady(event));
    on<DeleteStudentViewEvent>((event, emit) => _onDelete(event));
    on<DeletingStudentViewEvent>((event, emit) => _onDeleting(event));
    on<ErrorStudentViewEvent>((event, emit) => _onError(event));

    init(student);
  }

// - ADD EVENTS -
  void init(Student student) {
    try {
      StudentViewWrap viewWrap = StudentViewWrap(student: student);
      add(ReadyStudentViewEvent(viewWrap: viewWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toDelete() {
    add(DeleteStudentViewEvent(viewWrap: state.viewWrap!));
  }

  void toDeleting() async {
    try {
      await _repository.removeTeacherId(state.viewWrap!.student);
      NavigationService.clearRouteAndPushNamed(StudentsScreen.id, null);
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorStudentViewEvent(viewWrap: state.viewWrap, errMsg: errMsg));
  }

// - EVENT HANDLERS -
  void _onReady(ReadyStudentViewEvent event) {
    ReadyStudentViewState viewState =
        ReadyStudentViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDelete(DeleteStudentViewEvent event) {
    DeleteStudentViewState viewState =
        DeleteStudentViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onDeleting(DeletingStudentViewEvent event) {
    DeletingStudentViewState viewState =
        DeletingStudentViewState(viewWrap: event.viewWrap!);
    _setState(viewState);
  }

  void _onError(ErrorStudentViewEvent event) {
    ErrorStudentViewState viewState =
        ErrorStudentViewState(viewWrap: event.viewWrap, errMsg: event.errMsg);
    _setState(viewState);
  }

  void _setState(StudentViewState state) {
    emit(state);
  }
}
