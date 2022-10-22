import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/courses/course_view/course_view_bloc.dart';
import 'package:workbook/bloc/courses/course_view/course_view_wrap.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';

class CourseViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseViewBloc bloc = BlocProvider.of<CourseViewBloc>(context);
    final CourseViewWrap viewWrap = bloc.state.viewWrap!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Course.label),
      ),
      body: ScreenContainerCmp(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(viewWrap.course.name.value, style: ovTitleLargeStyle),
        ]),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: '$labelDelete ${Course.label}',
          color: Colors.redAccent,
          onPressed: bloc.toDelete),
    );
  }
}
