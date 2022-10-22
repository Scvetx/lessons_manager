/* Teacher's registration form
*/

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/rounded_button_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/screens/students/students_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(labelRegistration),
        ),
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
                title: labelCreateAccount,
                onPressed: () async {
                  setState(() => context.loaderOverlay.show());
                  try {
                    await FirebaseAuthService.auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    await FirebaseAuthService.updateUserName(labelNoName);
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
            ],
          ),
        ),
      ),
    );
  }
}
