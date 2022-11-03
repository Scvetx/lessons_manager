import 'package:bloc/bloc.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/students/student_repository.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/ui/screens/students/student_form_screen.dart';
import 'package:workbook/ui/screens/students/student_view_screen.dart';
import 'students_list_event.dart';
import 'students_list_state.dart';
import 'students_list_wrap.dart';

class StudentsListBloc extends Bloc<StudentsListEvent, StudentsListState> {
  final StudentRepository _repository = StudentRepository();

  // if students ids list is not passed in params then query all teacher's students
  StudentsListBloc({Set<String>? studentsIds})
      : super(LoadingStudentsListState()) {
    // --- state events: list layout ---
    on<ReadyStudentsListEvent>((event, emit) => _onReady(event));
    on<ErrorStudentsListEvent>((event, emit) => _onError(event));
    // --- actions events: list layout ---
    on<NewRecordStudentsListEvent>((event, emit) => _onNewRecord(event));
    // --- actions events: list item ---
    on<ViewRecordStudentsListEvent>((event, emit) => _onViewRecord(event));
    on<EditRecordStudentsListEvent>((event, emit) => _onEditRecord(event));

    init(studentsIds);
  }

// - ADD EVENTS -
// --- state events: list layout ---
  void init(Set<String>? studentsIds) async {
    try {
      List<Student> allStudents = await _repository.queryAllActiveStudents();
      List<Student> students = studentsIds == null
          ? allStudents
          : _repository.filterStudentsByIds(allStudents, studentsIds);
      StudentsListWrap listWrap = StudentsListWrap(students: students);
      add(ReadyStudentsListEvent(listWrap: listWrap));
    } on Exception catch (e) {
      toError(e.toString());
    }
  }

  void toError(String errMsg) {
    add(ErrorStudentsListEvent(listWrap: state.listWrap!, errMsg: errMsg));
  }

// --- actions events: list layout ---
  void toNewRecord() {
    add(NewRecordStudentsListEvent());
  }

// --- actions events: list item ---
  void toViewRecord(Student student) {
    add(ViewRecordStudentsListEvent(student: student));
  }

  void toEditRecord(Student student) {
    add(EditRecordStudentsListEvent(student: student));
  }

// - EVENT HANDLERS -
// --- state events: list layout ---
  void _onReady(ReadyStudentsListEvent event) {
    ReadyStudentsListState state =
        ReadyStudentsListState(listWrap: event.listWrap!);
    _setState(state);
  }

  void _onError(ErrorStudentsListEvent event) {
    ErrorStudentsListState state =
        ErrorStudentsListState(listWrap: event.listWrap!, errMsg: event.errMsg);
    _setState(state);
  }

// --- actions events: list layout ---
  void _onNewRecord(NewRecordStudentsListEvent event) {
    NavigationService.pushNamed(StudentFormScreen.id, null);
  }

// --- actions events: list item ---
  void _onViewRecord(ViewRecordStudentsListEvent event) async {
    // get courses which the student attends
    event.student.courses =
        await _repository.queryRelatedCourses(event.student.id!);

    NavigationService.pushNamed(StudentViewScreen.id, event.student);
  }

  void _onEditRecord(EditRecordStudentsListEvent event) async {
    // get courses which the student attends
    event.student.courses =
        await _repository.queryRelatedCourses(event.student.id!);

    NavigationService.pushNamed(StudentFormScreen.id, event.student);
  }

// --- set state ---
  void _setState(StudentsListState state) {
    emit(state);
  }
}
