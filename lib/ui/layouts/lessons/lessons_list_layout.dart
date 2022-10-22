/* List of lessons created by the teacher or from the global library
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_bloc.dart';
import 'package:workbook/bloc/lessons/lessons_list/lessons_list_wrap.dart';
import 'package:workbook/models/lesson.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/ui/components/lessons/lessons_list_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';

class LessonsListLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonsListBloc bloc = BlocProvider.of<LessonsListBloc>(context);
    final LessonsListWrap? listWrap = bloc.state.listWrap;

    if (listWrap == null) return Container();

    return Scaffold(
        appBar: AppBar(
          title: const Text(Lesson.labelPlural),
          actions: [
            AppMenuCmp(),
          ],
        ),
        body: ScreenContainerCmp(
          child: LessonsListCmp(lessons: listWrap.lessons),
        ),
        bottomNavigationBar: BottomButtonCmp(
            title: '$labelAdd ${Lesson.label}', onPressed: bloc.toNewRecord));
  }
}
