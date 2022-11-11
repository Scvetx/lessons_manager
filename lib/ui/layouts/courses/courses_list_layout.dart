/* A Layout fot courses_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_bloc.dart';
import 'package:workbook/bloc/courses/courses_list/courses_list_wrap.dart';
import 'package:workbook/constants/labels.dart';

import 'package:workbook/models/course.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';
import 'package:workbook/ui/components/courses/courses_list_cmp.dart';

class CoursesListLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CoursesListBloc bloc = BlocProvider.of<CoursesListBloc>(context);
    final CoursesListWrap? listWrap = bloc.state.listWrap;

    if (listWrap == null) return Container();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Course.labelPlural),
        actions: [AppMenuCmp()],
      ),
      body: ScreenContainerCmp(
        child: CoursesListCmp(),
      ),
      bottomNavigationBar: FirebaseAuthService.isTeacher
          ? BottomButtonCmp(
              title: '$labelAdd ${Course.label}', onPressed: bloc.toNewRecord)
          : null,
    );
  }
}
