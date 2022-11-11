/* Custom Widget - new student: popup wrap
*/

import 'package:flutter/material.dart';
import 'package:workbook/ui/components/app/popups/popup_wrap.dart';
import 'new_student_popup_actions_cmp.dart';
import 'new_student_popup_content_cmp.dart';
import 'new_student_popup_title_cmp.dart';

class NewStudentPopupWrap extends PopupWrap {
  NewStudentPopupWrap({required BuildContext formContext})
      : super(
            title: const NewStudentPopupTitleCmp(),
            content: NewStudentPopupContentCmp(formContext: formContext),
            actions: NewStudentPopupActionsCmp(formContext: formContext));
}
