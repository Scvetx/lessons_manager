/* A Layout fot course_view_screen.dart
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/courses/course_view/course_view_bloc.dart';
import 'package:workbook/bloc/courses/course_view/course_view_wrap.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/constants/styles/object_view_style.dart';

import 'package:workbook/models/student.dart';
import 'package:workbook/models/lesson.dart';
import 'package:workbook/models/course.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/buttons/section_button_cmp.dart';
import 'package:workbook/ui/components/app/text/description_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class CourseViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseViewBloc bloc = BlocProvider.of<CourseViewBloc>(context);
    if (bloc.state.viewWrap == null) return Container();
    final CourseViewWrap viewWrap = bloc.state.viewWrap!;
    final int numberOfStudents = viewWrap.course.courseAttendees!.length;
    final int numberOfLessons = viewWrap.course.lessons!.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Course.label),
      ),
      body: ScreenContainerCmp(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                    child: Text(viewWrap.course.name.value,
                        style: ovTitleLargeStyle)),
                Visibility(
                  visible: FirebaseAuthService.isTeacher,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: EditButtonCmp(
                      onPressed: () => bloc.toEditRecord(),
                    ),
                  ),
                ),
              ]),
              Visibility(
                visible: viewWrap.course.description.value.isNotEmpty,
                child: Column(children: [
                  const SizedBox(height: spaceBetweenLines),
                  DescriptiontCmp(text: viewWrap.course.description.value),
                ]),
              ),
              const SizedBox(height: spaceBetweenLinesSmall),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: FirebaseAuthService.isTeacher,
                      child: Padding(
                        padding: const EdgeInsets.only(top: spaceBetweenLines),
                        child: SectionTitleButtonCmp(
                            title: '${Student.labelPlural}: $numberOfStudents',
                            onPressed: bloc.toRelatedStudents),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: spaceBetweenLinesSmall),
                      child: SectionTitleButtonCmp(
                          title: '${Lesson.labelPlural}: $numberOfLessons',
                          onPressed: bloc.toRelatedLessons),
                    ),
                  ]),
            ]),
      ),
      bottomNavigationBar: FirebaseAuthService.isTeacher
          ? BottomButtonCmp(
              title: '$labelDelete ${Course.label}',
              color: Colors.redAccent,
              onPressed: bloc.toDelete)
          : null,
    );
  }
}
