/* Custom Widget - the main menu shown in the AppBar
*/

import 'package:flutter/material.dart';
import 'package:workbook/constants/menu.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';

class AppMenuCmp extends StatelessWidget {
  static String? curTab;

  final List<PopupMenuItem> menu =
      FirebaseAuthService.isTeacher ? teacherMenu : studentMenu;

  @override
  Widget build(BuildContext context) {
    navigateToScreen(String screenId) {
      curTab = screenId;
      Navigator.popAndPushNamed(context, screenId);
    }

    return PopupMenuButton(
      constraints: const BoxConstraints(
        minWidth: 150,
      ),
      itemBuilder: (context) => menu,
      onSelected: (val) => navigateToScreen(val.toString()),
    );
  }
}
