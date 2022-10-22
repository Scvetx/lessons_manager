/* A page where a teacher can view content of the lesson
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_view/lesson_view_state.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/lessons/lesson_view_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class LessonViewScreen extends StatelessWidget {
  static const String id = 'lesson_view_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    final initLesson = ModalRoute.of(context)!.settings.arguments as Lesson;

    return BlocProvider<LessonViewBloc>(
      create: (context) => LessonViewBloc(lesson: initLesson),
      child: BlocConsumer<LessonViewBloc, LessonViewState>(
        builder: (context, state) {
          return DisableScreenCmp(
            disable: state.disableScreen,
            child: LessonViewLayout(),
          );
        },
        listener: (context, state) {
          final LessonViewBloc bloc = BlocProvider.of<LessonViewBloc>(context);
          if (state is DeleteLessonViewState) {
            bloc.toDeleting();
          } else if (state is ErrorLessonViewState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
