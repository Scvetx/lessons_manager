/* List of student_view created by the teacher or from the global library
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_bloc.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_state.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/courses/courses_list_layout.dart';
import 'package:workbook/ui/layouts/app/loading_layout.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class CoursesScreen extends StatelessWidget {
  static const String id = 'courses_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

    return BlocProvider<CoursesListBloc>(
      create: (context) => CoursesListBloc(),
      child: BlocConsumer<CoursesListBloc, CoursesListState>(
        builder: (context, state) {
          if (state is LoadingCoursesListState) {
            return LoadingLayout(title: Course.labelPlural);
          } else {
            return CoursesListLayout();
          }
        },
        listener: (context, state) {
          final CoursesListBloc bloc =
              BlocProvider.of<CoursesListBloc>(context);
          if (state is ErrorCoursesListState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
