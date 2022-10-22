import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbook/bloc/courses/course_form/course_form_bloc.dart';
import 'package:workbook/bloc/courses/course_form/course_form_wrap.dart';
import 'package:workbook/models/course.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/form/form_cmp.dart';

class CourseFormLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CourseFormBloc bloc = BlocProvider.of<CourseFormBloc>(context);
    final CourseFormWrap formWrap = bloc.state.formWrap!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${formWrap.isNew ? labelNew : labelEdit} ${Course.label}'),
      ),
      body: ScreenContainerCmp(
          child: Column(children: [
        FormCmp(formWrap.fieldsMap),
      ])),
      bottomNavigationBar:
          BottomButtonCmp(title: labelSave, onPressed: bloc.toSave),
    );
  }
}
