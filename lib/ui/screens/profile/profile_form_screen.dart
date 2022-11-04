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
  Profile? _curProfileVal;
  Profile get _curProfile {
    _curProfileVal ??= Profile.fromUser(FirebaseAuthService.user!);
    return _curProfileVal!;
  }

  String? _password;
  bool _nameChanged = false;
  bool _emailChanged = false;

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) return ErrLoggedOutCmp();

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
                    curValue: _curProfile.name.value,
                    length: _curProfile.name.maxLength,
                    maxNumberOfLines: _curProfile.name.maxNumberOfLines,
                    onChange: (value) {
                      setState(() {
                        _curProfile.name.value = value;
                        _nameChanged = _curProfile.name.value !=
                            FirebaseAuthService.user!.displayName;
                      });
                    }),
                const SizedBox(height: spaceBetweenLinesSmall),
                TextInputCmp(
                    placeholder: Profile.fEmailLabel,
                    curValue: _curProfile.email.value,
                    length: _curProfile.email.maxLength,
                    maxNumberOfLines: _curProfile.email.maxNumberOfLines,
                    onChange: (value) {
                      setState(() {
                        _curProfile.email.value = value;
                        _emailChanged = _curProfile.email.value !=
                            FirebaseAuthService.user!.email;
                      });
                    }),
                const SizedBox(height: spaceBetweenLinesSmall),
                Visibility(
                  visible: _emailChanged,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _password = value;
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
          onPressed: () async {
            setState(() => context.loaderOverlay.show());
            try {
              if (_nameChanged) {
                _curProfile.validateName();
                await FirebaseAuthService.updateUserName(
                    _curProfile.name.value);
              }
              if (_emailChanged) {
                _curProfile.validateEmail(_password);
                await FirebaseAuthService.reauthenticateUser(_password!);
                await FirebaseAuthService.updateUserEmail(
                    _curProfile.email.value);
              }
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, ProfileViewScreen.id,
                  (Route<dynamic> route) => false);
            } on Exception catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarCmp(text: e.toString()));
            } finally {
              setState(() => context.loaderOverlay.hide());
            }
          },
        ),
      ),
    );
  }
}
