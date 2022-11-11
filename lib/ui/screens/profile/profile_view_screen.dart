/* A page where a teacher or a student can view profile card
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workbook/services/app/firebase/firebase_auth_service.dart';
import 'package:workbook/models/profile.dart';

import 'package:workbook/constants/labels.dart';
import 'package:workbook/constants/styles/object_view_style.dart';
import 'package:workbook/constants/styles/app_style.dart';
import 'package:workbook/ui/screens/profile/profile_form_screen.dart';
import 'package:workbook/ui/screens/profile/photo_edit_screen.dart';
import 'package:workbook/ui/layouts/app/err_logged_out_layout.dart';
import 'package:workbook/ui/components/app/containers/screen_container_cmp.dart';
import 'package:workbook/ui/components/app/popups/snack_bar_cmp.dart';
import 'package:workbook/ui/components/app/buttons/bottom_button_cmp.dart';
import 'package:workbook/ui/components/app/menu/app_menu_cmp.dart';
import 'package:workbook/ui/components/app/buttons/edit_button_cmp.dart';

class ProfileViewScreen extends StatefulWidget {
  static const String id = 'profile_view_screen';

  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  Profile? _profile;
  bool _loggingOut = false;

  void initProfile(User user) {
    _profile = FirebaseAuthService.isTeacher
        ? FirebaseAuthService.teacher!
        : FirebaseAuthService.student!;
    _profile!.setUserData(user);
  }

  void logOut() async {
    setState(() => _loggingOut = true);
    try {
      await FirebaseAuthService.logOut();
    } on Exception catch (e) {
      setState(() => _loggingOut = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarCmp(text: e.toString()));
    }
  }

  void toEditPhoto() {
    Navigator.pushNamed(context, PhotoEditScreen.id);
  }

  void toEditProfile() {
    Navigator.pushNamed(context, ProfileFormScreen.id, arguments: _profile);
  }

  @override
  Widget build(BuildContext context) {
    if (!FirebaseAuthService.loggedIn) ErrLoggedOutCmp();

    return Scaffold(
      appBar: AppBar(
        title: const Text('$labelMy ${Profile.label}'),
        actions: [
          AppMenuCmp(),
        ],
      ),
      body: ScreenContainerCmp(
        child: StreamBuilder<User?>(
            stream: FirebaseAuthService.auth.userChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              User user = snapshot.data as User;
              initProfile(user);
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.only(right: 24),
                        child: InkResponse(
                          onTap: toEditPhoto,
                          child: CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage(_profile!.photoURL)),
                        ),
                      ),
                      Expanded(
                          child: Text(_profile!.name.value,
                              style: ovTitleLargeStyle)),
                      Align(
                        alignment: Alignment.topRight,
                        child: EditButtonCmp(
                          onPressed: toEditProfile,
                        ),
                      ),
                    ]),
                    const SizedBox(height: spaceBetweenLines),
                    Row(children: [
                      SizedBox(
                        width: ovFirstColumnWidth,
                        child: Text('${Profile.fEmailLabel}:',
                            style: ovFieldLabelStyle),
                      ),
                      Text(_profile!.email.value),
                    ]),
                  ]); //,
            }),
      ),
      bottomNavigationBar: BottomButtonCmp(
          title: labelLogOut,
          color: Colors.redAccent,
          onPressed: _loggingOut ? null : logOut),
    );
  }
}
