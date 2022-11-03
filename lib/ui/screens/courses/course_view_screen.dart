/* A page where a teacher can view content of the course
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/courses/course_view/course_view_bloc.dart';
import 'package:workbook/bloc/courses/course_view/course_view_state.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/courses/course_view_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class CourseViewScreen extends StatelessWidget {
  static const String id = 'course_view_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    final initCourse = ModalRoute.of(context)!.settings.arguments as Course;

    return BlocProvider<CourseViewBloc>(
      create: (context) => CourseViewBloc(course: initCourse),
      child: BlocConsumer<CourseViewBloc, CourseViewState>(
        builder: (context, state) {
            return DisableScreenCmp(
              disable: state.disableScreen,
              child: CourseViewLayout(),
            );
        },
        listener: (context, state) {
          final CourseViewBloc bloc = BlocProvider.of<CourseViewBloc>(context);
          if (state is DeleteCourseViewState) {
            bloc.toDeleting();
          } else if (state is ErrorCourseViewState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
