/* login screen
*/

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/rounded_button_cmp.dart';
import 'package:workbook/ui/components/app/buttons/link_text.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ScreenContainerCmp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: inputTextDecoration.copyWith(
                  hintText: labelInputEmailHintText),
            ),
            const SizedBox(height: spaceBetweenLines),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: inputTextDecoration.copyWith(
                  hintText: labelInputPasswordHintText),
            ),
            const SizedBox(height: spaceBetweenLines),
            RoundedButtonCmp(
              title: labelLogIn,
              onPressed: () async {
                setState(() => context.loaderOverlay.show());
                try {
                  await FirebaseAuthService.auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (!mounted) return;
                  Navigator.popAndPushNamed(context, StudentsScreen.id);
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBarCmp(text: e.toString()));
                } finally {
                  setState(() => context.loaderOverlay.hide());
                }
              },
            ),
            const SizedBox(height: spaceBetweenLinesSmall),
            Center(
              child: LinkText(
                text: labelRegisterButton,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
