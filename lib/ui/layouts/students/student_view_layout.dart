/* A Layout fot student_view_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/students/student_view/student_view_bloc.dart';
import 'package:workbook/bloc/students/student_view/student_view_wrap.dart';
import 'package:workbook/models/student.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/courses/courses_names_row_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class StudentViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StudentViewBloc bloc = BlocProvider.of<StudentViewBloc>(context);
    if (bloc.state.viewWrap == null) return Container();
    final StudentViewWrap viewWrap = bloc.state.viewWrap!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('${Student.label} $labelCard'),
      ),
      body: ScreenContainerCmp(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
                child: Text(viewWrap.student.name.value,
                    style: ovTitleLargeStyle)),
            Align(
              alignment: Alignment.topRight,
              child: EditButtonCmp(
                onPressed: () => bloc.toEditRecord(),
              ),
            ),
          ]),
          const SizedBox(height: spaceBetweenLines),
          Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Text('${Profile.fEmailLabel}:', style: ovFieldLabelStyle),
            ),
            Text(viewWrap.student.email.value, style: ovLanguageLevelStyle),
          ]),
          const SizedBox(height: spaceBetweenLines),
          Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Text('${Student.fLanguageLevelLabel}:',
                  style: ovFieldLabelStyle),
            ),
            Text(viewWrap.student.languageLevel?.value ?? '',
                style: ovLanguageLevelStyle),
          ]),
          const SizedBox(height: spaceBetweenLines),
          Row(children: [
            SizedBox(
              width: ovFirstColumnWidth,
              child: Text('${Student.fGoalLabel}:', style: ovFieldLabelStyle),
            ),
            Text(viewWrap.student.goal?.value ?? '',
                style: ovLanguageLevelStyle),
          ]),
          const SizedBox(height: spaceBetweenLinesLarge),
          CoursesNamesRowCmp(coursesIds: viewWrap.student.coursesIds),
        ]),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: '$labelDeactivate ${Student.label}',
          color: Colors.redAccent,
          onPressed: bloc.toDelete),
    );
  }
}
