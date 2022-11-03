/* List of lessons created by the teacher
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_bloc.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_state.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/lessons/lessons_list_layout.dart';
import 'package:workbook/ui/layouts/app/loading_layout.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class LessonsScreen extends StatelessWidget {
  static const String id = 'lessons_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    Set<String>? lessonsIds =
        ModalRoute.of(context)?.settings.arguments as Set<String>?;

    return BlocProvider<LessonsListBloc>(
      create: (context) => LessonsListBloc(lessonsIds),
      child: BlocConsumer<LessonsListBloc, LessonsListState>(
        builder: (context, state) {
          if (state is LoadingLessonsListState) {
            return LoadingLayout(title: Lesson.labelPlural);
          } else {
            return LessonsListLayout();
          }
        },
        listener: (context, state) {
          if (state is ErrorLessonsListState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
