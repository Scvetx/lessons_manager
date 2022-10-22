/* Teacher's lessons schedule (calendar)
 */

import 'package:flutter/material.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';

import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';

class ScheduleScreen extends StatefulWidget {
  static const String id = 'schedule_screen';

  const ScheduleScreen({super.key});
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Schedule'),
          actions: [
            AppMenuCmp(),
          ],
        ),
        body: ScreenContainerCmp(
            child: Column(
          children: [
            Text('here will be the schedule'),
          ],
        )));
  }
}
