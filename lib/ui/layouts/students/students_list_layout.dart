/* A Layout fot students_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/students_list/students_list_bloc.dart';
import 'package:workbook/bloc/students/students_list/students_list_wrap.dart';
import 'package:workbook/models/student.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/students/students_list_cmp.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';

class StudentsListLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StudentsListBloc bloc = BlocProvider.of<StudentsListBloc>(context);
    final StudentsListWrap? listWrap = bloc.state.listWrap;

    if (listWrap == null) return Container();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Student.labelPlural),
        actions: listWrap.isRelatedList ? null : [AppMenuCmp()],
      ),
      body: ScreenContainerCmp(
        child: StudentsListCmp(),
      ),
      bottomNavigationBar: BottomButtonCmp(
        title: '$labelAdd ${Student.label}',
        onPressed: bloc.toNewRecord,
      ),
    );
  }
}
