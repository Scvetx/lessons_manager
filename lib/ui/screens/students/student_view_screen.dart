/* A page where a teacher can view info about the student
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/students/student_view/student_view_bloc.dart';
import 'package:workbook/bloc/students/student_view/student_view_state.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/students/student_view_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class StudentViewScreen extends StatelessWidget {
  static const String id = 'student_view_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    final initStudent = ModalRoute.of(context)!.settings.arguments as Student;

    return BlocProvider<StudentViewBloc>(
      create: (context) => StudentViewBloc(student: initStudent),
      child: BlocConsumer<StudentViewBloc, StudentViewState>(
        builder: (context, state) {
          return DisableScreenCmp(
            disable: state.disableScreen,
            child: StudentViewLayout(),
          );
        },
        listener: (context, state) {
          final StudentViewBloc bloc =
              BlocProvider.of<StudentViewBloc>(context);
          if (state is DeleteStudentViewState) {
            bloc.toDeleting();
          } else if (state is ErrorStudentViewState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
