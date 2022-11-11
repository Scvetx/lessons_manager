/* A form where a teacher can create/edit a teacher
 */

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/cobject.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/text/text_input_cmp.dart';
import 'profile_view_screen.dart';

class ProfileFormScreen extends StatefulWidget {
  static const String id = 'profile_form_screen';

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  dynamic _initProfile;
  dynamic _profile;
  String? _password;
  bool _nameChanged = false;
  bool _emailChanged = false;

  void initProfile() {
    _initProfile = _initProfile ??
        (FirebaseAuthService.isTeacher
            ? FirebaseAuthService.teacher
            : FirebaseAuthService.student);
    _profile = _profile ?? _initProfile.copy();
  }

  void onNameChanged(String value) {
    setState(() {
      _profile.name.value = value;
      _nameChanged = _profile.name.value != _initProfile!.name.value;
    });
  }

  void onEmailChanged(String value) {
    setState(() {
      _profile.email.value = value;
      _emailChanged = _profile.email.value != _initProfile!.email.value;
    });
  }

  void onPasswordChanged(String value) {
    _password = value;
  }

  void saveProfile() async {
    setState(() => context.loaderOverlay.show());
    try {
      if (_nameChanged) {
        _profile.validateName();
        await FirebaseAuthService.updateUserName(_profile.name.value);
        await FirebaseAuthService.updateUserProfile(_profile, _initProfile);
      }
      if (_emailChanged) {
        _profile.validateEmailEdit(_password);
        await FirebaseAuthService.reauthenticateUser(_password!);
        await FirebaseAuthService.updateUserEmail(_profile.email.value);
        await FirebaseAuthService.updateUserProfile(_profile, _initProfile);
      }
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, ProfileViewScreen.id, (Route<dynamic> route) => false);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    } finally {
      setState(() => context.loaderOverlay.hide());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

    initProfile();

    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('$labelEdit ${Profile.label}'),
        ),
        body: ScreenContainerCmp(
            child: Column(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputCmp(
                    placeholder: CObject.fNameLabel,
                    curValue: _profile.name.value,
                    length: _profile.name.maxLength,
                    maxNumberOfLines: _profile.name.maxNumberOfLines,
                    onChange: (value) {
                      onNameChanged(value);
                    }),
                const SizedBox(height: spaceBetweenLinesSmall),
                TextInputCmp(
                  placeholder: Profile.fEmailLabel,
                  curValue: _profile.email.value,
                  length: _profile.email.maxLength,
                  maxNumberOfLines: _profile.email.maxNumberOfLines,
                  onChange: (value) {
                    onEmailChanged(value);
                  },
                ),
                const SizedBox(height: spaceBetweenLinesSmall),
                Visibility(
                  visible: _emailChanged,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        onPasswordChanged(value);
                      },
                      decoration: inputTextDecoration.copyWith(
                        hintText: labelInputPasswordHintText,
                      ),
                    ),
                  ),
                ),
              ]),
        ])),
        bottomNavigationBar: BottomButtonCmp(
          title: labelSave,
          onPressed: saveProfile,
        ),
      ),
    );
  }
}
