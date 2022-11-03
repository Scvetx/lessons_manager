/* A list of students created by the teacher
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/students/students_list/students_list_bloc.dart';
import 'package:workbook/bloc/students/students_list/students_list_state.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/students/students_list_layout.dart';
import 'package:workbook/ui/layouts/app/loading_layout.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class StudentsScreen extends StatelessWidget {
  static const String id = 'students_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

    Set<String>? studentsIds =
        ModalRoute.of(context)?.settings.arguments as Set<String>?;

    return BlocProvider<StudentsListBloc>(
      create: (context) => StudentsListBloc(studentsIds: studentsIds),
      child: BlocConsumer<StudentsListBloc, StudentsListState>(
        builder: (context, state) {
          if (state is LoadingStudentsListState) {
            return LoadingLayout(title: Student.labelPlural);
          } else {
            return StudentsListLayout();
          }
        },
        listener: (context, state) {
          if (state is ErrorStudentsListState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
