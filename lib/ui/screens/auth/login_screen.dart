/* login screen
*/

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';

import 'package:workbook/constants/home_screen_id.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/rounded_button_cmp.dart';
import 'package:workbook/ui/components/app/buttons/link_text.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/screens/profile/password_update_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  void onEmailChanged(String value) {
    _email = value;
  }

  void onPasswordChanged(String value) {
    _password = value;
  }

  void login() async {
    setState(() => context.loaderOverlay.show());
    try {
      // sign in to firebase
      await FirebaseAuthService.auth
          .signInWithEmailAndPassword(email: _email, password: _password);
      // get current user teacher or student profile
      await FirebaseAuthService.initUserProfile();

      if (!mounted) return;
      // go to change password if it's the first student's login
      if (FirebaseAuthService.student != null &&
          !FirebaseAuthService.student!.isVerified) {
        Navigator.pushNamed(context, PasswordUpdateScreen.id);
        // go to home page otherwise
      } else {
        Navigator.popAndPushNamed(context, homeScreenId);
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    } finally {
      setState(() => context.loaderOverlay.hide());
    }
  }

  void toRegisterScreen() {
    Navigator.pushNamed(context, RegistrationScreen.id);
  }

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
                onEmailChanged(value);
              },
              decoration: inputTextDecoration.copyWith(
                  hintText: labelInputEmailHintText),
            ),
            const SizedBox(height: spaceBetweenLines),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                onPasswordChanged(value);
              },
              decoration: inputTextDecoration.copyWith(
                  hintText: labelInputPasswordHintText),
            ),
            const SizedBox(height: spaceBetweenLines),
            RoundedButtonCmp(title: labelLogIn, onPressed: login),
            const SizedBox(height: spaceBetweenLinesSmall),
            Center(
              child: LinkText(
                text: labelRegisterButton,
                onPressed: toRegisterScreen,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
