/* A form where a teacher can create/edit student's card
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/students/student_form/student_form_bloc.dart';
import 'package:workbook/bloc/students/student_form/student_form_state.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/students/student_form_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class StudentFormScreen extends StatelessWidget {
  static const String id = 'student_form_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    Student? initStudent =
        ModalRoute.of(context)?.settings.arguments as Student?;

    return BlocProvider<StudentFormBloc>(
      create: (context) => StudentFormBloc(student: initStudent),
      child: BlocConsumer<StudentFormBloc, StudentFormState>(
        builder: (context, state) {
          return DisableScreenCmp(
            disable: state.disableScreen,
            child: StudentFormLayout(),
          );
        },
        listener: (context, state) {
          final StudentFormBloc bloc =
              BlocProvider.of<StudentFormBloc>(context);
          if (state is SaveStudentFormState) {
            bloc.toSaving();
          } else if (state is ErrorStudentFormState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
