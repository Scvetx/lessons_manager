/* Teacher's registration form
*/

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/services/teachers/teacher_repository.dart';
import 'package:workbook/models/teacher.dart';

import 'package:workbook/constants/home_screen_id.dart';
import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/buttons/rounded_button_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TeacherRepository _repo = TeacherRepository();
  late Teacher _newTeacher;
  late String _password;

  @override
  void initState() {
    super.initState();
    _newTeacher = Teacher.create();
  }

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
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  _newTeacher.name.value = value;
                },
                decoration: inputTextDecoration.copyWith(
                    hintText: labelInputNameHintText),
              ),
              const SizedBox(height: spaceBetweenLines),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  _newTeacher.email.value = value;
                },
                decoration: inputTextDecoration.copyWith(
                    hintText: labelInputEmailHintText),
              ),
              const SizedBox(height: spaceBetweenLines),
              TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  _password = value;
                },
                decoration: inputTextDecoration.copyWith(
                    hintText: labelInputPasswordHintText),
              ),
              const SizedBox(height: spaceBetweenLinesLarge),
              RoundedButtonCmp(
                title: labelCreateAccount,
                onPressed: () async {
                  setState(() => context.loaderOverlay.show());
                  try {
                    // create a user in Firebase
                    await FirebaseAuthService.auth
                        .createUserWithEmailAndPassword(
                            email: _newTeacher.email.value,
                            password: _password);
                    // set user's name
                    await FirebaseAuthService.updateUserName(
                        _newTeacher.name.value);
                    _newTeacher.userId = FirebaseAuthService.userId!;
                    //
                    await _repo.createRecord(_newTeacher);
                    await FirebaseAuthService.initUserProfile();

                    if (!mounted) return;
                    Navigator.popAndPushNamed(context, homeScreenId);
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
