/* A form where a teacher can create/edit a course
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/courses/course_form/course_form_bloc.dart';
import 'package:workbook/bloc/courses/course_form/course_form_state.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/courses/course_form_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class CourseFormScreen extends StatelessWidget {
  static const String id = 'course_form_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    Course? initCourse = ModalRoute.of(context)?.settings.arguments as Course?;

    return BlocProvider<CourseFormBloc>(
      create: (context) => CourseFormBloc(course: initCourse),
      child: BlocConsumer<CourseFormBloc, CourseFormState>(
        builder: (context, state) {
          return DisableScreenCmp(
            disable: state.disableScreen,
            child: CourseFormLayout(),
          );
        },
        listener: (context, state) {
          final CourseFormBloc bloc = BlocProvider.of<CourseFormBloc>(context);
          if (state is SaveCourseFormState) {
            bloc.toSaving();
          } else if (state is ErrorCourseFormState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
