/* login screen
*/

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/app/navigation/navigation_service.dart';
import 'package:workbook/services/students/student_repository.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/home_screen_id.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/rounded_button_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class PasswordUpdateScreen extends StatefulWidget {
  static const String id = 'password_update_screen';

  @override
  _PasswordUpdateScreenState createState() => _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends State<PasswordUpdateScreen> {
  final StudentRepository _repo = StudentRepository();
  late String _newPassword;

  void updatePassword() async {
    setState(() => context.loaderOverlay.show());
    try {
      // update user password
      await FirebaseAuthService.updatePassword(_newPassword);
      // update student as verified
      await _repo.verifyStudent(FirebaseAuthService.student!);
      // go to home screen
      if (!mounted) return;
      NavigationService.clearRouteAndPushNamed(homeScreenId, null);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    } finally {
      setState(() => context.loaderOverlay.hide());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('$labelNew ${Profile.fPasswordLabel}'),
      ),
      body: ScreenContainerCmp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  labelNewPasswordDescription,
                  style: mBlackLongText,
                  textAlign: TextAlign.center,
                )),
            const SizedBox(height: spaceBetweenLinesLarge),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _newPassword = value;
              },
              decoration: inputTextDecoration.copyWith(
                  hintText: labelInputNewPasswordHintText),
            ),
            const SizedBox(height: spaceBetweenLines),
            RoundedButtonCmp(
              title: '$labelChange ${Profile.fPasswordLabel}',
              onPressed: updatePassword,
            ),
          ],
        ),
      ),
    ));
  }
}
