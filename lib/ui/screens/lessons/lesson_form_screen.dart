/* A form where a teacher can create/edit a lesson
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_bloc.dart';
import 'package:workbook/bloc/lessons/lesson_form/lesson_form_state.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/layouts/lessons/lesson_form_layout.dart';
import 'package:workbook/ui/components/app/overlay/disable_screen_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class LessonFormScreen extends StatelessWidget {
  static const String id = 'lesson_form_screen';

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();
    Lesson? initLesson = ModalRoute.of(context)?.settings.arguments as Lesson?;

    return BlocProvider<LessonFormBloc>(
      create: (context) => LessonFormBloc(lesson: initLesson),
      child: BlocConsumer<LessonFormBloc, LessonFormState>(
        builder: (context, state) {
          return DisableScreenCmp(
            disable: state.disableScreen,
            child: LessonFormLayout(),
          );
        },
        listener: (context, state) {
          final LessonFormBloc bloc = BlocProvider.of<LessonFormBloc>(context);
          if (state is SaveLessonFormState) {
            bloc.toSaving();
          } else if (state is ErrorLessonFormState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBarCmp(text: state.errMsg!));
          }
        },
      ),
    );
  }
}
